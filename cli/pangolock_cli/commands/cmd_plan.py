import subprocess
import click
from pangolock_cli.cli import pass_environment


@click.command("apply", short_help="Runs `terraform plan`")
@pass_environment
def cli(ctx):
    """
    Run apply, which runs terraform apply

    Generates an execution plan for Terraform.

    This execution plan can be reviewed prior to running apply to get a
    sense for what Terraform will do. Optionally, the plan can be saved to
    a Terraform plan file, and apply can take this plan file to execute
    this plan exactly.
    """

    process = subprocess.Popen(
        ["terraform", "plan"], stdout=subprocess.PIPE, stderr=subprocess.PIPE
    )
    stdout, stderr = process.communicate()

    ctx.log(stdout)
    ctx.log(stderr)
