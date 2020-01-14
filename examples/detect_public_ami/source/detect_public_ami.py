""" Module for PublicAMIRule """

import json

import boto3

from aws_rule import AWSRule


class PublicAMIRule(AWSRule):
    """ AWS rule for ensuring non-public AMIs """

    client = boto3.client("ec2")

    def __init__(self, event):
        super().__init__(event)

    def extract_event_data(self, event):
        """ Extract required data from the CloudWatch event """
        self.raw_event = event
        self.ami_image_id = event["detail"]["requestParameters"]["imageId"]

    def resource_compliant(self):
        is_compliant = True
        response = self.client.describe_image_attribute(
            Attribute="launchPermission", ImageId=self.ami_image_id
        )

        for permission in response["LaunchPermissions"]:
            try:
                if permission["Group"] == "all":
                    is_compliant = False
            except KeyError:
                continue

        return is_compliant

    def remediate(self):
        self.client.modify_image_attribute(
            Attribute="launchPermission",
            ImageId=self.ami_image_id,
            LaunchPermission={"Remove": [{"Group": "all"}]},
        )

    def get_remediation_message(self):
        """ Returns a message about the remediation action that occurred """
        return f"The AMI with ID: {self.ami_image_id} was made public. Public access has been disabled."


def lambda_handler(event, _):
    """ Handles the incoming event """
    print(event)
    rule = PublicAMIRule(json.loads(event["Records"][0]["body"]))
    rule.run_compliance_rule()
