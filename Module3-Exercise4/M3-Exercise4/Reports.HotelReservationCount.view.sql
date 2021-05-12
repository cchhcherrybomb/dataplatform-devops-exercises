CREATE VIEW Reports.HotelReservationCount AS
SELECT H.HotelId, H.Name AS HotelName, H.HotelState, COUNT(R.ReservationID) AS ReservationCount
FROM Vendors.Hotels H
INNER JOIN Booking.Reservations R ON H.HotelID = R.HotelID
GROUP BY H.HotelId, H.Name, H.HotelState
