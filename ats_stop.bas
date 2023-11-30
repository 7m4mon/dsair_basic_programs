' ATSŒx•ñ‚ÌƒeƒXƒg

DECLARE FUNCTION WaitForArriving(sens)

screen(7)
pwr 1
s88start

addr = 10

print "locaddr=";addr
fnc addr, 0, 1
sleep 100
dir addr,1
acc 54,1
sleep 900
acc 54,0
spd addr, 200

x = WaitForArriving(2)
acc 21, 1       'start bell
acc 22, 1       'start chime

x = WaitForArriving(3)
acc 21, 0       'stops bell
spd addr, 150   'speed down

x = WaitForArriving(4)
acc 22, 0       'stops chime
spd addr, 0     'train 

sleep 1500

acc 54,1
sleep 900
acc 54,0

dir addr,2      'return
sleep 100
spd addr, 300
x = WaitForArriving(1)
spd addr, 0

FUNCTION WaitForArriving(sens)
    while s88get(sens) = 0
        c$ = inkey$
        select case c$
            case "q":
            spd addr, 0
            print "Power off"
            pwr 0
            while 1
                sleep 10 'trap
            wend
        end select
        sleep 10
    wend
    print "arriving at ";sens
    WaitForArriving = 0
END FUNCTION
