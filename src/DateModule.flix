mod DateModule {
    pub enum Date {
        case DateYYYYMMDD(Int32, Int32, Int32)
    }

    instance Eq[Date] {
        pub def eq(x: Date, y: Date): Bool = match (x, y) {
                case (Date.DateYYYYMMDD(y1,m1,d1), Date.DateYYYYMMDD(y2,m2,d2)) if (y1 == y2 and m1 == m2 and d1 == d2) => true 
                case _ => false
            }
    }

    instance ToString[Date] {
        pub def toString(x: Date): String = match (x) {
            case Date.DateYYYYMMDD(y,m,d) => "Year ${y}, Month ${m} Day ${d}"
            case _ => "not a valid date"
        }
    }

    def isValidDate(year: Int32, month: Int32, day: Int32): Bool = 
        if (year < 0 or month < 1 or month > 12 or day < 1 or day > 31) {
            false
        } else {
            if (day > numOfDaysInMonth(month, year)) {
                false
            } else {
                true
            }
        }
    
    def numOfDaysInMonth(month: Int32, year: Int32): Int32 = match(month) {
            case 1 => 31
            case 2 if isLeapYear(year) => 29
            case 2 if not isLeapYear(year) => 28
            case _ if Int32.modulo(month, 2) == 0 => 30
            case _ => 31
        }

    def isLeapYear(year: Int32): Bool = 
        Int32.modulo(year, 4) == 0 and (Int32.modulo(year, 100) != 100 or Int32.modulo(year, 400) == 0)

    pub def createYYYYMMDD(year: Int32, month: Int32, day: Int32): Result[String,Date] = 
        match(isValidDate(year, month, day)) {
            case true => Ok(Date.DateYYYYMMDD(year, month, day))
            case false => Err("Invalid date - year ${year} or month ${month} or day ${day} is not valid")
        }
    


    def incrementDateByOneDay(date: Date): Result[String, Date] =
        match(date) {
            case Date.DateYYYYMMDD(y,m,d) if d+1 <= numOfDaysInMonth(m, y) => createYYYYMMDD(y, m, d+1)
            case Date.DateYYYYMMDD(y,m,d) if d+1 > numOfDaysInMonth(m, y) and m < 12 => createYYYYMMDD(y, m+1, 1)
            case Date.DateYYYYMMDD(y,m,d) if d+1 > numOfDaysInMonth(m, y) and m == 12 => createYYYYMMDD(y+1, 1, 1)
            case _ => Err("Something bad happened")
        }

    pub def numOfDaysBetween(fromDate: Date, toDate: Date): Result[String, Int32] = 
        if (fromDate == toDate) {
            Ok(0)
        } else {
            match(incrementDateByOneDay(fromDate)) {
                case Ok(newDate) => match(numOfDaysBetween(newDate, toDate)) {
                    case Ok(num) => Ok(1+num)
                    case _ => Err("??")
                }
                case _ => Err("Something bad happened")
            }
        }

}
