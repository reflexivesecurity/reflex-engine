from setuptools import setup

setup(
    name="pangolock",
    version="0.1.0",
    packages=["pangolock_cli", "pangolock_cli.commands"],
    include_package_data=True,
    install_requires=["click",],
    entry_points="""
        [console_scripts]
        pangolock=pangolock_cli.cli:cli
    """,
)
