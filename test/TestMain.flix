use Date.create
use Date.Date

@Test
def testValidDate(): Bool =
    let date1 = create(2024,1,1);
    let date2 = Date(2024,1,1);
    Assert.eq(date1, date2)
//    create(1,2,3)