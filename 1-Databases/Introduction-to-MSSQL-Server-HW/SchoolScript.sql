USE [School]
GO
/****** Object:  Table [dbo].[Classes]    Script Date: 06/21/2015 16:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Classes](
	[ClassId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](30) NOT NULL,
	[MaxStudents] [int] NOT NULL,
 CONSTRAINT [PK_Classes] PRIMARY KEY CLUSTERED 
(
	[ClassId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Classes] ON
INSERT [dbo].[Classes] ([ClassId], [Name], [MaxStudents]) VALUES (1, N'Geography', 30)
INSERT [dbo].[Classes] ([ClassId], [Name], [MaxStudents]) VALUES (2, N'Mathematics', 25)
INSERT [dbo].[Classes] ([ClassId], [Name], [MaxStudents]) VALUES (3, N'Programming', 30)
INSERT [dbo].[Classes] ([ClassId], [Name], [MaxStudents]) VALUES (4, N'English', 30)
INSERT [dbo].[Classes] ([ClassId], [Name], [MaxStudents]) VALUES (5, N'History', 20)
INSERT [dbo].[Classes] ([ClassId], [Name], [MaxStudents]) VALUES (6, N'Biology', 25)
SET IDENTITY_INSERT [dbo].[Classes] OFF
/****** Object:  Table [dbo].[Students]    Script Date: 06/21/2015 16:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[StudentId] [int] IDENTITY(1,1) NOT NULL,
	[ClassId] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Age] [int] NOT NULL,
	[PhoneNumber] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_Students] PRIMARY KEY CLUSTERED 
(
	[StudentId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Students] ON
INSERT [dbo].[Students] ([StudentId], [ClassId], [Name], [Age], [PhoneNumber]) VALUES (1, 3, N'Pesho Peshov', 14, N'0888999888')
INSERT [dbo].[Students] ([StudentId], [ClassId], [Name], [Age], [PhoneNumber]) VALUES (2, 1, N'Mariika Mariikova', 16, N'0888111222')
INSERT [dbo].[Students] ([StudentId], [ClassId], [Name], [Age], [PhoneNumber]) VALUES (3, 2, N'Gosho Goshov', 11, N'0999333111')
INSERT [dbo].[Students] ([StudentId], [ClassId], [Name], [Age], [PhoneNumber]) VALUES (4, 2, N'Pencho Penchov', 9, N'0888777555')
INSERT [dbo].[Students] ([StudentId], [ClassId], [Name], [Age], [PhoneNumber]) VALUES (5, 6, N'Kiro Kirov', 14, N'0888000444')
INSERT [dbo].[Students] ([StudentId], [ClassId], [Name], [Age], [PhoneNumber]) VALUES (7, 4, N'Latinka Latinkova', 10, N'0888666000')
INSERT [dbo].[Students] ([StudentId], [ClassId], [Name], [Age], [PhoneNumber]) VALUES (8, 2, N'Veliko Velikov', 8, N'0260050043')
INSERT [dbo].[Students] ([StudentId], [ClassId], [Name], [Age], [PhoneNumber]) VALUES (9, 1, N'Vasil Vasilev', 11, N'0877111222')
INSERT [dbo].[Students] ([StudentId], [ClassId], [Name], [Age], [PhoneNumber]) VALUES (10, 1, N'Pancho Panchev', 11, N'0261361488')
SET IDENTITY_INSERT [dbo].[Students] OFF
/****** Object:  ForeignKey [FK_Students_Classes]    Script Date: 06/21/2015 16:15:01 ******/
ALTER TABLE [dbo].[Students]  WITH CHECK ADD  CONSTRAINT [FK_Students_Classes] FOREIGN KEY([ClassId])
REFERENCES [dbo].[Classes] ([ClassId])
GO
ALTER TABLE [dbo].[Students] CHECK CONSTRAINT [FK_Students_Classes]
GO
