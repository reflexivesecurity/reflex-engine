""" Module for the AWSRule class """

import os

import boto3


class AWSRule:
    """ Generic class for AWS compliance rules """

    def __init__(self, event):
        """ Initialize the rule object """
        self.extract_event_data(event)
        self.pre_remediation_functions = []
        self.post_remediation_functions = [self.notify_via_sns]

    def extract_event_data(self, event):
        """ Extracts data from the event """
        raise NotImplementedError("extract_event_data not implemented")

    def run_compliance_rule(self):
        """ Runs all steps of the compliance rule """
        if not self.resource_compliant():
            self.pre_remediation()
            self.remediate()
            self.post_remediation()

    def resource_compliant(self):
        """ Returns True if the resource is compliant, False otherwise """
        raise NotImplementedError("resource_compliant not implemented")

    def remediate(self):
        """ Fixes the configuration of the non-compliant resource """
        raise NotImplementedError("remediate not implemented")

    def pre_remediation(self):
        """ Any steps to take before remediating the resource """
        for pre_remediation_function in self.pre_remediation_functions:
            pre_remediation_function()

    def post_remediation(self):
        """ Any steps to take after remediating the resource """
        for post_remediation_function in self.post_remediation_functions:
            post_remediation_function()

    def get_remediation_message(self):
        """ Returns a message about the remediation action that occurred """
        return "A resource was remediated."

    def notify_via_sns(self):
        """ Notify via SNS that the resource has been remediated """
        client = boto3.client("sns")
        sns_topic = os.environ["SNS_TOPIC"]
        message = self.get_remediation_message()

        client.publish(TopicArn=sns_topic, Message=message)
