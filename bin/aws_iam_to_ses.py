#!/usr/bin/env python3
"""Script to convert IAM credentials to SES credentials.

https://docs.aws.amazon.com/ses/latest/DeveloperGuide/smtp-credentials.html#smtp-credentials-convert
"""

import argparse
import base64
import hashlib
import hmac
from typing import Union

# Values that are required to calculate the signature. These values should
# never change.
DATE = "11111111"
SERVICE = "ses"
MESSAGE = "SendRawEmail"
TERMINAL = "aws4_request"
VERSION = 0x04


def sign(key: Union[bytes, bytearray], msg: str) -> bytes:
    return hmac.new(key, msg.encode("utf-8"), hashlib.sha256).digest()


def calculate_key(secret_access_key: str, region: str) -> None:
    signature = sign(("AWS4" + secret_access_key).encode("utf-8"), DATE)
    signature = sign(signature, region)
    signature = sign(signature, SERVICE)
    signature = sign(signature, TERMINAL)
    signature = sign(signature, MESSAGE)
    signature_and_version = bytes([VERSION]) + signature
    smtp_password = base64.b64encode(signature_and_version)
    print(smtp_password.decode("utf-8"))


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Convert a Secret Access Key for an IAM user to an SMTP password."
    )
    parser.add_argument(
        "--secret",
        help="The Secret Access Key that you want to convert.",
        required=True,
        action="store",
    )
    parser.add_argument(
        "--region",
        help="The name of the AWS Region that the SMTP password will be used in.",
        required=True,
        choices=[
            "us-east-2",  # US East (Ohio)
            "us-east-1",  # US East (N. Virginia)
            "us-west-2",  # US West (Oregon)
            "ap-south-1",  # Asia Pacific (Mumbai)
            "ap-northeast-2",  # Asia Pacific (Seoul)
            "ap-southeast-1",  # Asia Pacific (Singapore)
            "ap-southeast-2",  # Asia Pacific (Sydney)
            "ap-northeast-1",  # Asia Pacific (Tokyo)
            "ca-central-1",  # Canada (Central)
            "eu-central-1",  # Europe (Frankfurt)
            "eu-west-1",  # Europe (Ireland)
            "eu-west-2",  # Europe (London)
            "sa-east-1",  # South America (Sao Paulo)
            "us-gov-west-1",  # AWS GovCloud (US)
        ],
        action="store",
    )
    args = parser.parse_args()

    calculate_key(args.secret, args.region)


if __name__ == "__main__":
    main()
