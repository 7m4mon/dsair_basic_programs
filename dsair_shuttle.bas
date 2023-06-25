' ‰•œ‰^“]

screen(7)
pwr 1
s88start

addr = 7
speed = 300
print "locaddr=";addr

while 1
    dir addr,2
    print "Goto Place 1"
    sleep 100
    spd addr,speed
    
    while s88get(1)=0
        c$ = inkey$
        if (c$ = "q") then
            spd addr, 0
        end if
    wend
    
    spd addr,0
    print "S88 Adr.1 Detected"
    sleep 800

    dir addr,1
    print "Goto Place 2"
    sleep 100
    spd addr,speed
    while s88get(2)=0
        c$ = inkey$
        if (c$ = "q") then
            spd addr, 0
        end if
    wend

    spd addr,0
    print "S88 Adr.2 Detected"
    sleep 800
wend

