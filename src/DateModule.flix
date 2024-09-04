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
            true
        }

    pub def createYYYYMMDD(year: Int32, month: Int32, day: Int32): Result[String,Date] = 
        match(isValidDate(year, month, day)) {
            case true => Ok(Date.DateYYYYMMDD(year, month, day))
            case false => Err("Invalid date - year ${year} or month ${month} or day ${day} is not valid")
        }
}
