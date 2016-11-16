import funds_gather_moneydance_extension.funds_gather_moneydance_extension as P
import pytest
import os
import logging

import smtplib
from mock import Mock
from mock import patch, call
from mock import MagicMock
from mock import PropertyMock


class Testfunds_gather_moneydance_extension:

    def setup(self):
        self.p = P.FundsGatherExtension()
