import subprocess
import click
from pangolock_cli.cli import pass_environment


@click.command("apply", short_help="Runs `terraform apply`")
@pass_environment
def cli(ctx):
    """
    Run apply, which runs terraform apply

    Builds or changes infrastructure according to Terraform configuration
    files in DIR.

    By default, apply scans the current directory for the configuration
    and applies the changes appropriately. However, a path to another
    configuration or an execution plan can be provided. Execution plans can be
    used to only execute a pre-determined set of actions.
    """

    process = subprocess.Popen("terraform apply", shell=True)
    stdout, stderr = process.communicate()

    ctx.log(stdout)
    ctx.log(stderr)
