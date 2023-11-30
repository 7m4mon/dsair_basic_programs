print "start"

pwr 1

addr = 10

sleep 1000
fnc addr, 0, 1

FOR i = 1 to 10
print "1"
dir addr, 1 'FWD=1, REV=2
sleep 1000
print "2"
dir addr, 2 'FWD=1, REV=2
sleep 1000
next i

print "end"
pwr 0