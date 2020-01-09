import subprocess
import click
from pangolock_cli.cli import pass_environment


@click.command("init", short_help="Runs `terraform init`")
@click.argument("tf_args", nargs=-1)
@pass_environment
def cli(ctx):
    """
    Run init, which runs terraform init

    Initialize a new or existing Terraform working directory by creating
    initial files, loading any remote state, downloading modules, etc.

    This is the first command that should be run for any new or existing
    Terraform configuration per machine. This sets up all the local data
    necessary to run Terraform that is typically not committed to version
    control.

    This command is always safe to run multiple times. Though subsequent runs
    may give errors, this command will never delete your configuration or
    state. Even so, if you have important information, please back it up prior
    to running this command, just in case.

    If no arguments are given, the configuration in this working directory
    is initialized.
    """

    tf_args_str = " ".join(tf_args)
    process = subprocess.Popen("terraform plan {tf_args_str}", shell=True)
    stdout, stderr = process.communicate()

    ctx.log(stdout)
    ctx.log(stderr)
