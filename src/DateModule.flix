pub enum Date {
    case Date(Int32, Int32, Int32)
}

instance Eq[Date] {
    pub def eq(x: Date, y: Date): Bool = match (x, y) {
            case (Date.Date(y1,m1,d1), Date.Date(y2,m2,d2)) if (y1 == y2 and m1 == m2 and d1 == d2) => true 
            case _ => false
        }
}

instance ToString[Date] {
    pub def toString(x: Date): String = match (x) {
        case Date.Date(y,m,d) => "${y}, ${m} ${d}"
        case _ => "not a valid date"
    }
}

mod Date {
    pub def create(year: Int32, month: Int32, day: Int32): Date = Date(year, month, day)

}
