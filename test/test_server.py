import sys
from server_functions import *

resp = send_message(RequestCode.REPORT, "Accident Reported!")
print(resp)
