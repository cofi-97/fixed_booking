USE [FixedBookings]
GO
ALTER TABLE [dbo].[SingleBookings] DROP CONSTRAINT [FK_SingleBookings_ReservedDates]
GO
ALTER TABLE [dbo].[SingleBookings] DROP CONSTRAINT [FK_SingleBookings_Bookings]
GO
ALTER TABLE [dbo].[ReservedDates] DROP CONSTRAINT [FK_ReservedDates_Fields]
GO
ALTER TABLE [dbo].[Fields] DROP CONSTRAINT [FK_Fields_Sports]
GO
ALTER TABLE [dbo].[Bookings] DROP CONSTRAINT [FK_Bookings_Fields]
GO
/****** Object:  Table [dbo].[Sports]    Script Date: 05-May-2021 14:30:39 ******/
DROP TABLE [dbo].[Sports]
GO
/****** Object:  Table [dbo].[SingleBookings]    Script Date: 05-May-2021 14:30:39 ******/
DROP TABLE [dbo].[SingleBookings]
GO
/****** Object:  Table [dbo].[ReservedDates]    Script Date: 05-May-2021 14:30:39 ******/
DROP TABLE [dbo].[ReservedDates]
GO
/****** Object:  Table [dbo].[Fields]    Script Date: 05-May-2021 14:30:39 ******/
DROP TABLE [dbo].[Fields]
GO
/****** Object:  Table [dbo].[Bookings]    Script Date: 05-May-2021 14:30:39 ******/
DROP TABLE [dbo].[Bookings]
GO
USE [master]
GO
/****** Object:  Database [FixedBookings]    Script Date: 05-May-2021 14:30:39 ******/
DROP DATABASE [FixedBookings]
GO
/****** Object:  Database [FixedBookings]    Script Date: 05-May-2021 14:30:39 ******/
CREATE DATABASE [FixedBookings]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'FixedBookings', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\FixedBookings.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'FixedBookings_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\FixedBookings_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [FixedBookings] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FixedBookings].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [FixedBookings] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [FixedBookings] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [FixedBookings] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [FixedBookings] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [FixedBookings] SET ARITHABORT OFF 
GO
ALTER DATABASE [FixedBookings] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [FixedBookings] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [FixedBookings] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [FixedBookings] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [FixedBookings] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [FixedBookings] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [FixedBookings] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [FixedBookings] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [FixedBookings] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [FixedBookings] SET  DISABLE_BROKER 
GO
ALTER DATABASE [FixedBookings] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [FixedBookings] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [FixedBookings] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [FixedBookings] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [FixedBookings] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [FixedBookings] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [FixedBookings] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [FixedBookings] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [FixedBookings] SET  MULTI_USER 
GO
ALTER DATABASE [FixedBookings] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [FixedBookings] SET DB_CHAINING OFF 
GO
ALTER DATABASE [FixedBookings] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [FixedBookings] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [FixedBookings] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [FixedBookings] SET QUERY_STORE = OFF
GO
USE [FixedBookings]
GO
/****** Object:  Table [dbo].[Bookings]    Script Date: 05-May-2021 14:30:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bookings](
	[BookingID] [int] IDENTITY(1,1) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CustomerName] [nvarchar](50) NOT NULL,
	[ContactNumber] [nvarchar](50) NOT NULL,
	[Field] [int] NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[Comment] [nvarchar](500) NULL,
 CONSTRAINT [PK_Bookings] PRIMARY KEY CLUSTERED 
(
	[BookingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fields]    Script Date: 05-May-2021 14:30:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fields](
	[FieldID] [int] IDENTITY(1,1) NOT NULL,
	[FieldName] [nvarchar](50) NOT NULL,
	[FieldLocation] [nvarchar](50) NOT NULL,
	[Sport] [int] NOT NULL,
 CONSTRAINT [PK_Fields] PRIMARY KEY CLUSTERED 
(
	[FieldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReservedDates]    Script Date: 05-May-2021 14:30:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReservedDates](
	[DateID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [date] NOT NULL,
	[Time] [time](7) NOT NULL,
	[Field] [int] NOT NULL,
 CONSTRAINT [PK_ReservedDates] PRIMARY KEY CLUSTERED 
(
	[DateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SingleBookings]    Script Date: 05-May-2021 14:30:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SingleBookings](
	[SingleBookingID] [int] IDENTITY(1,1) NOT NULL,
	[BookingID] [int] NOT NULL,
	[Date] [int] NOT NULL,
 CONSTRAINT [PK_SingleBookings] PRIMARY KEY CLUSTERED 
(
	[SingleBookingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sports]    Script Date: 05-May-2021 14:30:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sports](
	[SportID] [int] IDENTITY(1,1) NOT NULL,
	[SportName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Sports] PRIMARY KEY CLUSTERED 
(
	[SportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Bookings] ON 

INSERT [dbo].[Bookings] ([BookingID], [CreatedOn], [CustomerName], [ContactNumber], [Field], [StartDate], [EndDate], [Comment]) VALUES (4, CAST(N'2021-05-05T11:37:17.837' AS DateTime), N'test', N'test', 2, CAST(N'2021-05-05' AS Date), CAST(N'2021-05-07' AS Date), N'test')
INSERT [dbo].[Bookings] ([BookingID], [CreatedOn], [CustomerName], [ContactNumber], [Field], [StartDate], [EndDate], [Comment]) VALUES (7, CAST(N'2021-05-05T13:38:16.870' AS DateTime), N'Test 2', N'Test 2', 6, CAST(N'2021-05-05' AS Date), CAST(N'2021-05-12' AS Date), N'Test 2')
SET IDENTITY_INSERT [dbo].[Bookings] OFF
SET IDENTITY_INSERT [dbo].[Fields] ON 

INSERT [dbo].[Fields] ([FieldID], [FieldName], [FieldLocation], [Sport]) VALUES (1, N'TestField1', N'TestLocation', 1)
INSERT [dbo].[Fields] ([FieldID], [FieldName], [FieldLocation], [Sport]) VALUES (2, N'TestField2', N'TestLocation2', 3)
INSERT [dbo].[Fields] ([FieldID], [FieldName], [FieldLocation], [Sport]) VALUES (3, N'TestField3', N'TestLocation3', 2)
INSERT [dbo].[Fields] ([FieldID], [FieldName], [FieldLocation], [Sport]) VALUES (6, N'TestField4', N'TestLocation4', 4)
SET IDENTITY_INSERT [dbo].[Fields] OFF
SET IDENTITY_INSERT [dbo].[ReservedDates] ON 

INSERT [dbo].[ReservedDates] ([DateID], [Date], [Time], [Field]) VALUES (9, CAST(N'2021-05-05' AS Date), CAST(N'09:00:00' AS Time), 2)
INSERT [dbo].[ReservedDates] ([DateID], [Date], [Time], [Field]) VALUES (10, CAST(N'2021-05-05' AS Date), CAST(N'11:00:00' AS Time), 2)
INSERT [dbo].[ReservedDates] ([DateID], [Date], [Time], [Field]) VALUES (11, CAST(N'2021-05-07' AS Date), CAST(N'09:00:00' AS Time), 2)
INSERT [dbo].[ReservedDates] ([DateID], [Date], [Time], [Field]) VALUES (21, CAST(N'2021-05-06' AS Date), CAST(N'09:00:00' AS Time), 6)
INSERT [dbo].[ReservedDates] ([DateID], [Date], [Time], [Field]) VALUES (22, CAST(N'2021-05-06' AS Date), CAST(N'11:00:00' AS Time), 6)
INSERT [dbo].[ReservedDates] ([DateID], [Date], [Time], [Field]) VALUES (23, CAST(N'2021-05-06' AS Date), CAST(N'16:00:00' AS Time), 6)
INSERT [dbo].[ReservedDates] ([DateID], [Date], [Time], [Field]) VALUES (25, CAST(N'2021-05-08' AS Date), CAST(N'11:00:00' AS Time), 6)
INSERT [dbo].[ReservedDates] ([DateID], [Date], [Time], [Field]) VALUES (26, CAST(N'2021-05-08' AS Date), CAST(N'16:00:00' AS Time), 6)
INSERT [dbo].[ReservedDates] ([DateID], [Date], [Time], [Field]) VALUES (27, CAST(N'2021-05-11' AS Date), CAST(N'09:00:00' AS Time), 6)
INSERT [dbo].[ReservedDates] ([DateID], [Date], [Time], [Field]) VALUES (29, CAST(N'2021-05-11' AS Date), CAST(N'16:00:00' AS Time), 6)
SET IDENTITY_INSERT [dbo].[ReservedDates] OFF
SET IDENTITY_INSERT [dbo].[SingleBookings] ON 

INSERT [dbo].[SingleBookings] ([SingleBookingID], [BookingID], [Date]) VALUES (1, 4, 9)
INSERT [dbo].[SingleBookings] ([SingleBookingID], [BookingID], [Date]) VALUES (2, 4, 10)
INSERT [dbo].[SingleBookings] ([SingleBookingID], [BookingID], [Date]) VALUES (3, 4, 11)
INSERT [dbo].[SingleBookings] ([SingleBookingID], [BookingID], [Date]) VALUES (13, 7, 21)
INSERT [dbo].[SingleBookings] ([SingleBookingID], [BookingID], [Date]) VALUES (14, 7, 22)
INSERT [dbo].[SingleBookings] ([SingleBookingID], [BookingID], [Date]) VALUES (15, 7, 23)
INSERT [dbo].[SingleBookings] ([SingleBookingID], [BookingID], [Date]) VALUES (17, 7, 25)
INSERT [dbo].[SingleBookings] ([SingleBookingID], [BookingID], [Date]) VALUES (18, 7, 26)
INSERT [dbo].[SingleBookings] ([SingleBookingID], [BookingID], [Date]) VALUES (19, 7, 27)
INSERT [dbo].[SingleBookings] ([SingleBookingID], [BookingID], [Date]) VALUES (21, 7, 29)
SET IDENTITY_INSERT [dbo].[SingleBookings] OFF
SET IDENTITY_INSERT [dbo].[Sports] ON 

INSERT [dbo].[Sports] ([SportID], [SportName]) VALUES (1, N'Football')
INSERT [dbo].[Sports] ([SportID], [SportName]) VALUES (2, N'Basketball')
INSERT [dbo].[Sports] ([SportID], [SportName]) VALUES (3, N'VolleyBall')
INSERT [dbo].[Sports] ([SportID], [SportName]) VALUES (4, N'Tennis')
INSERT [dbo].[Sports] ([SportID], [SportName]) VALUES (5, N'Futsal')
INSERT [dbo].[Sports] ([SportID], [SportName]) VALUES (6, N'Squash')
INSERT [dbo].[Sports] ([SportID], [SportName]) VALUES (7, N'Handball')
INSERT [dbo].[Sports] ([SportID], [SportName]) VALUES (8, N'Biking')
SET IDENTITY_INSERT [dbo].[Sports] OFF
ALTER TABLE [dbo].[Bookings]  WITH CHECK ADD  CONSTRAINT [FK_Bookings_Fields] FOREIGN KEY([Field])
REFERENCES [dbo].[Fields] ([FieldID])
GO
ALTER TABLE [dbo].[Bookings] CHECK CONSTRAINT [FK_Bookings_Fields]
GO
ALTER TABLE [dbo].[Fields]  WITH CHECK ADD  CONSTRAINT [FK_Fields_Sports] FOREIGN KEY([Sport])
REFERENCES [dbo].[Sports] ([SportID])
GO
ALTER TABLE [dbo].[Fields] CHECK CONSTRAINT [FK_Fields_Sports]
GO
ALTER TABLE [dbo].[ReservedDates]  WITH CHECK ADD  CONSTRAINT [FK_ReservedDates_Fields] FOREIGN KEY([Field])
REFERENCES [dbo].[Fields] ([FieldID])
GO
ALTER TABLE [dbo].[ReservedDates] CHECK CONSTRAINT [FK_ReservedDates_Fields]
GO
ALTER TABLE [dbo].[SingleBookings]  WITH CHECK ADD  CONSTRAINT [FK_SingleBookings_Bookings] FOREIGN KEY([BookingID])
REFERENCES [dbo].[Bookings] ([BookingID])
GO
ALTER TABLE [dbo].[SingleBookings] CHECK CONSTRAINT [FK_SingleBookings_Bookings]
GO
ALTER TABLE [dbo].[SingleBookings]  WITH CHECK ADD  CONSTRAINT [FK_SingleBookings_ReservedDates] FOREIGN KEY([Date])
REFERENCES [dbo].[ReservedDates] ([DateID])
GO
ALTER TABLE [dbo].[SingleBookings] CHECK CONSTRAINT [FK_SingleBookings_ReservedDates]
GO
USE [master]
GO
ALTER DATABASE [FixedBookings] SET  READ_WRITE 
GO
