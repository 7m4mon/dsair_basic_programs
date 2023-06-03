DECLARE FUNCTION GetTrainAddr(n)
DECLARE FUNCTION UpdateLocoPosition()
DECLARE FUNCTION WaitForArriving(sens)
DECLARE FUNCTION StopAllTrain()

tr1_addr = 70
tr2_addr = 33
tr3_addr = 25
mov_addr = 0

tr1_position = 2
tr2_position = 3
tr3_position = 1
empty_position = 4

SPD_SLOW = 150

screen(7)

pwr 1
s88start
x = StopAllTrain()

print "start"

while 1
    print "Go to ";empty_position
    select case empty_position
        case 1: ' 3 -> 1
            acc 1, 1    'diverse=0, straight=1
            sleep 500   'Charging time
            acc 2, 1    '
            sleep 500   'Charging time
            
            mov_addr = GetTrainAddr(3)
            dir mov_addr, 2 'FWD=1, REV=2
            sleep 100
            spd mov_addr, SPD_SLOW
            
            x = WaitForArriving(1)
            print "arrive at ";empty_position
            
            spd mov_addr, 0
            x = UpdateLocoPosition()
            empty_position = 3
            
        case 2: '4 -> 2
            acc 1, 0    'diverse=0, straight=1
            sleep 500   'Charging time
            acc 2, 0    '
            sleep 500   'Charging time
            
            mov_addr = GetTrainAddr(4)
            dir mov_addr, 2 'FWD=1, REV=2
            sleep 100
            spd mov_addr, SPD_SLOW
            
            x = WaitForArriving(3)
            print "arrive at ";empty_position
            
            spd mov_addr, 0
            x = UpdateLocoPosition()
            empty_position = 4
            
        case 3: ' 2 -> 3
            acc 2, 0    'diverse=0, straight=1
            sleep 500   'Charging time
            acc 1, 1    '
            sleep 500   'Charging time
            
            mov_addr = GetTrainAddr(2)
            dir mov_addr, 1 'FWD=1, REV=2
            sleep 100
            spd mov_addr, SPD_SLOW
            
            x = WaitForArriving(5)
            print "arrive at ";empty_position
            
            spd mov_addr, 0
            x = UpdateLocoPosition()
            empty_position = 2
            
        case 4: ' 1 -> 4
            acc 2, 1    'diverse=0, straight=1
            sleep 500   'Charging time
            acc 1, 0    '
            sleep 500   'Charging time
            
            mov_addr = GetTrainAddr(1)
            dir mov_addr, 1 'FWD=1, REV=2
            sleep 100
            spd mov_addr, SPD_SLOW
            
            x = WaitForArriving(7)
            print "arrive at ";empty_position
            
            spd mov_addr, 0
            x = UpdateLocoPosition()
            empty_position = 1
    end select
    
wend



' get loco addr at station.
FUNCTION GetTrainAddr(n)
    retval = 0
    if n = tr1_position then
        retval = tr1_addr
    end if
    if n = tr2_position then
        retval = tr2_addr
    end if
    if n = tr3_position then
        retval = tr3_addr
    end if
    if retval = 0 then
        print "NO_TRAIN"
        pwr 0
    end if
    print "at=";n
    print "loco=";retval
    GetTrainAddr = retval
END FUNCTION

'UpdateLocoPosition
FUNCTION UpdateLocoPosition()
    ' UpdateLocoPosition
    if mov_addr = tr1_addr then
        tr1_position = empty_position
    end if
    if mov_addr = tr2_addr then
        tr2_position = empty_position
    end if
    if mov_addr = tr3_addr then
        tr3_position = empty_position
    end if
    UpdateLocoPosition = 0
END FUNCTION

FUNCTION WaitForArriving(sens)
    while s88get(sens) = 0
        c$ = inkey$
        select case c$
            case "q":
            x = StopAllTrain()
            print "Power off"
            pwr 0
            while 1
                sleep 10 'trap
            wend
        end select
        sleep 10
    wend
    WaitForArriving = 0
END FUNCTION

FUNCTION StopAllTrain()
    spd tr1_addr, 0
    spd tr2_addr, 0
    spd tr3_addr, 0
    StopAllTrain = 0
END FUNCTION
