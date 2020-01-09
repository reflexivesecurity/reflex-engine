import subprocess
import click
from pangolock_cli.cli import pass_environment


@click.command("tf", short_help="`terraform ...`")
@click.argument("tf_args", nargs=-1)
@pass_environment
def cli(ctx, tf_args):
    """
    Wrapper for terraform

    Use `--` to pass additional arguments to terrafrom.

    Example:
        `pangolock tf version`
        `pangolock tf -- plan -out tf.out`

    """

    tf_args_str = " ".join(tf_args)
    process = subprocess.Popen(f"terraform {tf_args_str}", shell=True)
    stdout, stderr = process.communicate()

    ctx.log(stdout)
    ctx.log(stderr)
