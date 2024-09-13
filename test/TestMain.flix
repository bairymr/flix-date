use DateModule.createYYYYMMDD
use DateModule.Date

@Test
def testValidDate(): Bool =
    let maybeDate = createYYYYMMDD(2024,1,1);
    match(maybeDate) {
        case Ok(date) => Assert.eq(date, Date.DateYYYYMMDD(2024,1,1))
        case Err(_) => false
    }

@Test
def testInValidMonth(): Bool =
    let maybeDate = createYYYYMMDD(2024,-1,21);
    match(maybeDate) {
        case Ok(_) => false
        case Err(_) => true
    }

@Test
def testInValidDay(): Bool =
    let maybeDate = createYYYYMMDD(2024,1,41);
    match(maybeDate) {
        case Ok(_) => false
        case Err(_) => true
    }

@Test
def testNumDaysBetweenDates(): Bool =
    let fromDate = createYYYYMMDD(2024,1,1);
    let toDate = createYYYYMMDD(2024,2,1);
    match (fromDate, toDate) {
        case (Ok(date1), Ok(date2)) => DateModule.numOfDaysBetween(date1, date2) == Ok(31)
        case _ => false
    }
