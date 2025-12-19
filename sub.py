
import argparse

parser = argparse.ArgumentParser(
            prog = "sub.py",
            description="subtracts 2 floats",
            epilog= "boh"
)
parser.add_argument ('first')
parser.add_argument ('second')

args = parser.parse_args()
firstNum = float(args.first)
secondNum = float (args.second)
print ("DIBL is :", (firstNum - secondNum)*1e3, "mV")
