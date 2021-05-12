EXEC tSQLt.NewTestClass 'Reports_HotelReservationCount_Tests';
GO
CREATE PROCEDURE Reports_HotelReservationCount_Tests.[test no reservations] 
AS
BEGIN
	EXEC tSQLt.FakeTable @TableName = N'Hotels', @SchemaName = N'Vendors';
	EXEC tSQLt.FakeTable @TableName = N'Reservations', @SchemaName = N'Booking';

	SELECT HotelId, HotelName, HotelState, ReservationCount
	INTO #Actual
	FROM Reports.HotelReservationCount

	EXEC tSQLt.AssertEmptyTable #Actual;
	
END;
GO

CREATE PROCEDURE Reports_HotelReservationCount_Tests.[test one reservation for one hotel] 
AS
BEGIN
	EXEC tSQLt.FakeTable @TableName = N'Hotels', @SchemaName = N'Vendors';
	EXEC tSQLt.FakeTable @TableName = N'Reservations', @SchemaName = N'Booking';

	INSERT INTO Vendors.Hotels
	(
	    HotelId,
	    Name,
	    HotelState,
	    CostPerNight,
	    AdditionalColumns
	)
	VALUES
	(   1,    -- HotelId - int
	    N'OliviaHotel',  -- Name - nvarchar(400)

	    'AZ',   -- HotelState - char(2)
	    500, -- CostPerNight - numeric(10, 2)
	    NULL  -- AdditionalColumns - binary(200)
	    )

	INSERT INTO Booking.Reservations
	(
	    ReservationId,
	    CustomerId,
	    HotelId,
	    AdditionalColumns
	)
	VALUES
	(   1,   -- ReservationId - int
	    1,   -- CustomerId - int
	    1,   -- HotelId - int
	    NULL -- AdditionalColumns - binary(200)
	    )

	SELECT HotelId, HotelName, HotelState, ReservationCount
	INTO #Actual
	FROM Reports.HotelReservationCount

	SELECT TOP 0 *
	INTO #Expected
	FROM #Actual

	INSERT INTO #Expected (HotelId, HotelName, HotelState, ReservationCount) 
				   VALUES (1,'OliviaHotel', 'AZ',1);

	EXEC tSQLt.AssertEqualsTable #Expected, #Actual;
	
END;
GO

CREATE PROCEDURE Reports_HotelReservationCount_Tests.[test three reservations for one hotel] 
AS
BEGIN
	EXEC tSQLt.FakeTable @TableName = N'Hotels', @SchemaName = N'Vendors';
	EXEC tSQLt.FakeTable @TableName = N'Reservations', @SchemaName = N'Booking';

	INSERT INTO Vendors.Hotels
	(
	    HotelId,
	    Name,
	    HotelState,
	    CostPerNight,
	    AdditionalColumns
	)
	VALUES
	(   1,    -- HotelId - int
	    N'OliviaHotel',  -- Name - nvarchar(400)

	    'AZ',   -- HotelState - char(2)
	    500, -- CostPerNight - numeric(10, 2)
	    NULL  -- AdditionalColumns - binary(200)
	    )

	INSERT INTO Booking.Reservations
	(
	    ReservationId,
	    CustomerId,
	    HotelId,
	    AdditionalColumns
	)
	VALUES
	(   1,   -- ReservationId - int
	    1,   -- CustomerId - int
	    1,   -- HotelId - int
	    NULL -- AdditionalColumns - binary(200)
	    )

	SELECT HotelId, HotelName, HotelState, ReservationCount
	INTO #Actual
	FROM Reports.HotelReservationCount

	SELECT TOP 0 *
	INTO #Expected
	FROM #Actual

	INSERT INTO #Expected (HotelId, HotelName, HotelState, ReservationCount) 
				   VALUES (1,'OliviaHotel', 'AZ',3);

	EXEC tSQLt.AssertEqualsTable #Expected, #Actual;
	
END;
GO
