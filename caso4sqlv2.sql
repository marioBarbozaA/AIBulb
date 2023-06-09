USE [master]
GO
/****** Object:  Database [Caso4]    Script Date: 4/23/2023 4:47:27 AM ******/
CREATE DATABASE [Caso4]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Caso4', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Caso4.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Caso4_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Caso4_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Caso4] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Caso4].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Caso4] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Caso4] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Caso4] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Caso4] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Caso4] SET ARITHABORT OFF 
GO
ALTER DATABASE [Caso4] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Caso4] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Caso4] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Caso4] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Caso4] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Caso4] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Caso4] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Caso4] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Caso4] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Caso4] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Caso4] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Caso4] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Caso4] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Caso4] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Caso4] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Caso4] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Caso4] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Caso4] SET RECOVERY FULL 
GO
ALTER DATABASE [Caso4] SET  MULTI_USER 
GO
ALTER DATABASE [Caso4] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Caso4] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Caso4] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Caso4] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Caso4] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Caso4] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Caso4', N'ON'
GO
ALTER DATABASE [Caso4] SET QUERY_STORE = ON
GO
ALTER DATABASE [Caso4] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Caso4]
GO
/****** Object:  Table [dbo].[Cargos]    Script Date: 4/23/2023 4:47:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cargos](
	[CargoId] [smallint] IDENTITY(1,1) NOT NULL,
	[tipoCargoId] [tinyint] NOT NULL,
	[precio] [smallint] NOT NULL,
	[descripcion] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Cargos] PRIMARY KEY CLUSTERED 
(
	[CargoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CargosXLugar]    Script Date: 4/23/2023 4:47:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CargosXLugar](
	[CargoId] [smallint] NOT NULL,
	[lugarId] [smallint] NOT NULL,
	[estado] [bit] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categorías]    Script Date: 4/23/2023 4:47:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categorías](
	[categoriaId] [tinyint] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
	[descripcion] [nvarchar](200) NULL,
 CONSTRAINT [PK_Categorías] PRIMARY KEY CLUSTERED 
(
	[categoriaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CategoriasXServicio]    Script Date: 4/23/2023 4:47:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoriasXServicio](
	[servicioId] [smallint] NOT NULL,
	[categoriaId] [tinyint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Consultas]    Script Date: 4/23/2023 4:47:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Consultas](
	[consultaId] [int] IDENTITY(1,1) NOT NULL,
	[contenido] [nvarchar](400) NOT NULL,
	[fecha] [datetime] NOT NULL,
	[personaId] [int] NOT NULL,
 CONSTRAINT [PK_Consultas] PRIMARY KEY CLUSTERED 
(
	[consultaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contratos]    Script Date: 4/23/2023 4:47:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contratos](
	[contratoId] [int] IDENTITY(1,1) NOT NULL,
	[proveedorId] [int] NOT NULL,
	[fechaInicio] [datetime] NOT NULL,
	[fechaExpiración] [datetime] NOT NULL,
 CONSTRAINT [PK_Contratos] PRIMARY KEY CLUSTERED 
(
	[contratoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmpresasWallets]    Script Date: 4/23/2023 4:47:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmpresasWallets](
	[empresaWalletId] [tinyint] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_EmpresasWallets] PRIMARY KEY CLUSTERED 
(
	[empresaWalletId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EstadosRequests]    Script Date: 4/23/2023 4:47:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EstadosRequests](
	[estadoRequest] [tinyint] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
	[descripcion] [nvarchar](100) NULL,
 CONSTRAINT [PK_EstadosRequests] PRIMARY KEY CLUSTERED 
(
	[estadoRequest] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Leyes]    Script Date: 4/23/2023 4:47:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Leyes](
	[leyId] [smallint] IDENTITY(1,1) NOT NULL,
	[codigo] [nvarchar](50) NULL,
	[articulo] [nvarchar](50) NOT NULL,
	[nombre] [nvarchar](80) NOT NULL,
	[descripcion] [nvarchar](300) NOT NULL,
	[tipoLeyId] [tinyint] NULL,
	[precio] [money] NULL,
 CONSTRAINT [PK_Leyes] PRIMARY KEY CLUSTERED 
(
	[leyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LeyesXLugar]    Script Date: 4/23/2023 4:47:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeyesXLugar](
	[leyId] [smallint] NOT NULL,
	[lugarId] [smallint] NOT NULL,
	[vigente] [bit] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Localizaciones]    Script Date: 4/23/2023 4:47:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Localizaciones](
	[localizacionId] [smallint] IDENTITY(1,1) NOT NULL,
	[direccion] [geography] NOT NULL,
	[codigoZip] [char](5) NOT NULL,
	[borrado] [bit] NOT NULL,
	[lugarId] [smallint] NOT NULL,
 CONSTRAINT [PK_Localizaciones] PRIMARY KEY CLUSTERED 
(
	[localizacionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LocalizacionesXPersonas]    Script Date: 4/23/2023 4:47:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LocalizacionesXPersonas](
	[localizacionXPersonaId] [smallint] IDENTITY(1,1) NOT NULL,
	[personaId] [int] NOT NULL,
	[localizacionId] [smallint] NOT NULL,
	[actual] [bit] NOT NULL,
 CONSTRAINT [PK_LocalizacionesXPersonas] PRIMARY KEY CLUSTERED 
(
	[localizacionXPersonaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LocalizacionesXProveedor]    Script Date: 4/23/2023 4:47:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LocalizacionesXProveedor](
	[localizacionXPersonaId] [smallint] IDENTITY(1,1) NOT NULL,
	[proveedorId] [int] NOT NULL,
	[localizacionId] [smallint] NOT NULL,
	[actual] [bit] NOT NULL,
 CONSTRAINT [PK_LocalizacionesXProveedor] PRIMARY KEY CLUSTERED 
(
	[localizacionXPersonaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lugares]    Script Date: 4/23/2023 4:47:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lugares](
	[lugarId] [smallint] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](60) NOT NULL,
	[levelParent] [smallint] NOT NULL,
 CONSTRAINT [PK_Lugares] PRIMARY KEY CLUSTERED 
(
	[lugarId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LugaresXContrato]    Script Date: 4/23/2023 4:47:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LugaresXContrato](
	[contratoId] [int] NOT NULL,
	[lugarId] [smallint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Modelos]    Script Date: 4/23/2023 4:47:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Modelos](
	[modeloId] [tinyint] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
	[descripcion] [nvarchar](200) NULL,
 CONSTRAINT [PK_Modelos] PRIMARY KEY CLUSTERED 
(
	[modeloId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ModelosXServicio]    Script Date: 4/23/2023 4:47:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ModelosXServicio](
	[modeloId] [tinyint] NOT NULL,
	[servicioId] [smallint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PalabrasClave]    Script Date: 4/23/2023 4:47:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PalabrasClave](
	[palabraClaveId] [smallint] IDENTITY(1,1) NOT NULL,
	[palabra] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_PalabrasClave] PRIMARY KEY CLUSTERED 
(
	[palabraClaveId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PalabrasClaveXServicio]    Script Date: 4/23/2023 4:47:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PalabrasClaveXServicio](
	[palabraClaveId] [smallint] NOT NULL,
	[servicioId] [smallint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Paquetes]    Script Date: 4/23/2023 4:47:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Paquetes](
	[paqueteId] [tinyint] IDENTITY(1,1) NOT NULL,
	[planesGratis] [smallint] NOT NULL,
	[planesPagas] [smallint] NOT NULL,
	[descripcion] [varchar](200) NOT NULL,
	[proveedorId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Personas]    Script Date: 4/23/2023 4:47:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Personas](
	[personaId] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
	[apellido] [nvarchar](50) NOT NULL,
	[email] [nvarchar](254) NOT NULL,
	[domicilio] [geography] NOT NULL,
 CONSTRAINT [PK_Personas] PRIMARY KEY CLUSTERED 
(
	[personaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Proveedores]    Script Date: 4/23/2023 4:47:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Proveedores](
	[proveedorId] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nchar](10) NULL,
	[idTipoProveedor] [tinyint] NOT NULL,
 CONSTRAINT [PK_Proveedores] PRIMARY KEY CLUSTERED 
(
	[proveedorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Requests]    Script Date: 4/23/2023 4:47:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Requests](
	[requestId] [int] IDENTITY(1,1) NOT NULL,
	[consultaId] [int] NOT NULL,
	[servicioId] [smallint] NOT NULL,
	[transaccionId] [int] NOT NULL,
	[estadoRequestId] [tinyint] NOT NULL,
	[fecha] [datetime] NOT NULL,
 CONSTRAINT [PK_Requests] PRIMARY KEY CLUSTERED 
(
	[requestId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Resenas]    Script Date: 4/23/2023 4:47:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Resenas](
	[resenaId] [smallint] IDENTITY(1,1) NOT NULL,
	[personaId] [int] NOT NULL,
	[contenido] [nvarchar](300) NULL,
	[calificacion] [tinyint] NOT NULL,
	[fecha] [datetime] NOT NULL,
 CONSTRAINT [PK_Resenas] PRIMARY KEY CLUSTERED 
(
	[resenaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ResenasXProveedores]    Script Date: 4/23/2023 4:47:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ResenasXProveedores](
	[resenaId] [smallint] NOT NULL,
	[proveedorId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ResenasXServicio]    Script Date: 4/23/2023 4:47:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ResenasXServicio](
	[resenaId] [smallint] NOT NULL,
	[servicioId] [smallint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Servicios]    Script Date: 4/23/2023 4:47:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Servicios](
	[servicioId] [smallint] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
	[descripcion] [nvarchar](200) NULL,
	[precio] [money] NOT NULL,
 CONSTRAINT [PK_Servicios] PRIMARY KEY CLUSTERED 
(
	[servicioId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServiciosXContrato]    Script Date: 4/23/2023 4:47:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiciosXContrato](
	[servicioId] [nchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServiciosXProveedor]    Script Date: 4/23/2023 4:47:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiciosXProveedor](
	[proveedorId] [int] NOT NULL,
	[servicioId] [smallint] NOT NULL,
	[lugarId] [smallint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoCargos]    Script Date: 4/23/2023 4:47:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoCargos](
	[tipoCargoId] [tinyint] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_TipoCargos] PRIMARY KEY CLUSTERED 
(
	[tipoCargoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TiposLeyes]    Script Date: 4/23/2023 4:47:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TiposLeyes](
	[tipoLeyId] [tinyint] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_TiposLeyes] PRIMARY KEY CLUSTERED 
(
	[tipoLeyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TiposProveedores]    Script Date: 4/23/2023 4:47:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TiposProveedores](
	[idTipoProveedor] [tinyint] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
	[descripcion] [nvarchar](200) NULL,
 CONSTRAINT [PK_TiposProveedores] PRIMARY KEY CLUSTERED 
(
	[idTipoProveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transacciones]    Script Date: 4/23/2023 4:47:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transacciones](
	[transaccionId] [int] IDENTITY(1,1) NOT NULL,
	[fecha] [datetime] NOT NULL,
	[total] [money] NOT NULL,
	[descripcion] [nvarchar](200) NULL,
	[numeroReferencia] [nvarchar](200) NOT NULL,
	[nombreComputadora] [nvarchar](50) NOT NULL,
	[IP] [int] NULL,
	[walletId] [smallint] NOT NULL,
	[idTransaccionWallet] [varchar](200) NOT NULL,
	[personaId] [int] NULL,
	[proveedorId] [int] NULL,
 CONSTRAINT [PK_Transacciones] PRIMARY KEY CLUSTERED 
(
	[transaccionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Wallets]    Script Date: 4/23/2023 4:47:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Wallets](
	[walletId] [smallint] IDENTITY(1,1) NOT NULL,
	[nombre] [nchar](10) NULL,
	[identificador] [nvarchar](160) NOT NULL,
	[empresaWalletId] [tinyint] NOT NULL,
	[personaId] [int] NOT NULL,
 CONSTRAINT [PK_Wallets] PRIMARY KEY CLUSTERED 
(
	[walletId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Cargos]  WITH CHECK ADD  CONSTRAINT [FK_Cargos_TipoCargos] FOREIGN KEY([tipoCargoId])
REFERENCES [dbo].[TipoCargos] ([tipoCargoId])
GO
ALTER TABLE [dbo].[Cargos] CHECK CONSTRAINT [FK_Cargos_TipoCargos]
GO
ALTER TABLE [dbo].[CargosXLugar]  WITH CHECK ADD  CONSTRAINT [FK_CargosXLugar_Cargos] FOREIGN KEY([CargoId])
REFERENCES [dbo].[Cargos] ([CargoId])
GO
ALTER TABLE [dbo].[CargosXLugar] CHECK CONSTRAINT [FK_CargosXLugar_Cargos]
GO
ALTER TABLE [dbo].[CargosXLugar]  WITH CHECK ADD  CONSTRAINT [FK_CargosXLugar_Lugares] FOREIGN KEY([lugarId])
REFERENCES [dbo].[Lugares] ([lugarId])
GO
ALTER TABLE [dbo].[CargosXLugar] CHECK CONSTRAINT [FK_CargosXLugar_Lugares]
GO
ALTER TABLE [dbo].[CategoriasXServicio]  WITH CHECK ADD  CONSTRAINT [FK_CategoriasXServicio_Categorías] FOREIGN KEY([categoriaId])
REFERENCES [dbo].[Categorías] ([categoriaId])
GO
ALTER TABLE [dbo].[CategoriasXServicio] CHECK CONSTRAINT [FK_CategoriasXServicio_Categorías]
GO
ALTER TABLE [dbo].[CategoriasXServicio]  WITH CHECK ADD  CONSTRAINT [FK_CategoriasXServicio_Servicios] FOREIGN KEY([servicioId])
REFERENCES [dbo].[Servicios] ([servicioId])
GO
ALTER TABLE [dbo].[CategoriasXServicio] CHECK CONSTRAINT [FK_CategoriasXServicio_Servicios]
GO
ALTER TABLE [dbo].[Consultas]  WITH CHECK ADD  CONSTRAINT [FK_Consultas_Personas] FOREIGN KEY([personaId])
REFERENCES [dbo].[Personas] ([personaId])
GO
ALTER TABLE [dbo].[Consultas] CHECK CONSTRAINT [FK_Consultas_Personas]
GO
ALTER TABLE [dbo].[Contratos]  WITH CHECK ADD  CONSTRAINT [FK_Contratos_Proveedores] FOREIGN KEY([proveedorId])
REFERENCES [dbo].[Proveedores] ([proveedorId])
GO
ALTER TABLE [dbo].[Contratos] CHECK CONSTRAINT [FK_Contratos_Proveedores]
GO
ALTER TABLE [dbo].[Leyes]  WITH CHECK ADD  CONSTRAINT [FK_Leyes_TiposLeyes] FOREIGN KEY([tipoLeyId])
REFERENCES [dbo].[TiposLeyes] ([tipoLeyId])
GO
ALTER TABLE [dbo].[Leyes] CHECK CONSTRAINT [FK_Leyes_TiposLeyes]
GO
ALTER TABLE [dbo].[LeyesXLugar]  WITH CHECK ADD  CONSTRAINT [FK_LeyesXLugar_Leyes] FOREIGN KEY([leyId])
REFERENCES [dbo].[Leyes] ([leyId])
GO
ALTER TABLE [dbo].[LeyesXLugar] CHECK CONSTRAINT [FK_LeyesXLugar_Leyes]
GO
ALTER TABLE [dbo].[LeyesXLugar]  WITH CHECK ADD  CONSTRAINT [FK_LeyesXLugar_Lugares] FOREIGN KEY([lugarId])
REFERENCES [dbo].[Lugares] ([lugarId])
GO
ALTER TABLE [dbo].[LeyesXLugar] CHECK CONSTRAINT [FK_LeyesXLugar_Lugares]
GO
ALTER TABLE [dbo].[Localizaciones]  WITH CHECK ADD  CONSTRAINT [FK_Localizaciones_Lugares] FOREIGN KEY([lugarId])
REFERENCES [dbo].[Lugares] ([lugarId])
GO
ALTER TABLE [dbo].[Localizaciones] CHECK CONSTRAINT [FK_Localizaciones_Lugares]
GO
ALTER TABLE [dbo].[LocalizacionesXPersonas]  WITH CHECK ADD  CONSTRAINT [FK_LocalizacionesXPersonas_Localizaciones] FOREIGN KEY([localizacionId])
REFERENCES [dbo].[Localizaciones] ([localizacionId])
GO
ALTER TABLE [dbo].[LocalizacionesXPersonas] CHECK CONSTRAINT [FK_LocalizacionesXPersonas_Localizaciones]
GO
ALTER TABLE [dbo].[LocalizacionesXPersonas]  WITH CHECK ADD  CONSTRAINT [FK_LocalizacionesXPersonas_Personas] FOREIGN KEY([personaId])
REFERENCES [dbo].[Personas] ([personaId])
GO
ALTER TABLE [dbo].[LocalizacionesXPersonas] CHECK CONSTRAINT [FK_LocalizacionesXPersonas_Personas]
GO
ALTER TABLE [dbo].[LocalizacionesXProveedor]  WITH CHECK ADD  CONSTRAINT [FK_LocalizacionesXProveedor_Localizaciones] FOREIGN KEY([localizacionXPersonaId])
REFERENCES [dbo].[Localizaciones] ([localizacionId])
GO
ALTER TABLE [dbo].[LocalizacionesXProveedor] CHECK CONSTRAINT [FK_LocalizacionesXProveedor_Localizaciones]
GO
ALTER TABLE [dbo].[LocalizacionesXProveedor]  WITH CHECK ADD  CONSTRAINT [FK_LocalizacionesXProveedor_Proveedores] FOREIGN KEY([proveedorId])
REFERENCES [dbo].[Proveedores] ([proveedorId])
GO
ALTER TABLE [dbo].[LocalizacionesXProveedor] CHECK CONSTRAINT [FK_LocalizacionesXProveedor_Proveedores]
GO
ALTER TABLE [dbo].[Lugares]  WITH CHECK ADD  CONSTRAINT [FK_Lugares_Lugares] FOREIGN KEY([levelParent])
REFERENCES [dbo].[Lugares] ([lugarId])
GO
ALTER TABLE [dbo].[Lugares] CHECK CONSTRAINT [FK_Lugares_Lugares]
GO
ALTER TABLE [dbo].[LugaresXContrato]  WITH CHECK ADD  CONSTRAINT [FK_LugaresXContrato_Contratos] FOREIGN KEY([contratoId])
REFERENCES [dbo].[Contratos] ([contratoId])
GO
ALTER TABLE [dbo].[LugaresXContrato] CHECK CONSTRAINT [FK_LugaresXContrato_Contratos]
GO
ALTER TABLE [dbo].[LugaresXContrato]  WITH CHECK ADD  CONSTRAINT [FK_LugaresXContrato_Lugares] FOREIGN KEY([lugarId])
REFERENCES [dbo].[Lugares] ([lugarId])
GO
ALTER TABLE [dbo].[LugaresXContrato] CHECK CONSTRAINT [FK_LugaresXContrato_Lugares]
GO
ALTER TABLE [dbo].[ModelosXServicio]  WITH CHECK ADD  CONSTRAINT [FK_ModelosXServicio_Modelos] FOREIGN KEY([modeloId])
REFERENCES [dbo].[Modelos] ([modeloId])
GO
ALTER TABLE [dbo].[ModelosXServicio] CHECK CONSTRAINT [FK_ModelosXServicio_Modelos]
GO
ALTER TABLE [dbo].[ModelosXServicio]  WITH CHECK ADD  CONSTRAINT [FK_ModelosXServicio_Servicios] FOREIGN KEY([servicioId])
REFERENCES [dbo].[Servicios] ([servicioId])
GO
ALTER TABLE [dbo].[ModelosXServicio] CHECK CONSTRAINT [FK_ModelosXServicio_Servicios]
GO
ALTER TABLE [dbo].[PalabrasClaveXServicio]  WITH CHECK ADD  CONSTRAINT [FK_PalabrasClaveXServicio_PalabrasClave] FOREIGN KEY([palabraClaveId])
REFERENCES [dbo].[PalabrasClave] ([palabraClaveId])
GO
ALTER TABLE [dbo].[PalabrasClaveXServicio] CHECK CONSTRAINT [FK_PalabrasClaveXServicio_PalabrasClave]
GO
ALTER TABLE [dbo].[PalabrasClaveXServicio]  WITH CHECK ADD  CONSTRAINT [FK_PalabrasClaveXServicio_Servicios] FOREIGN KEY([servicioId])
REFERENCES [dbo].[Servicios] ([servicioId])
GO
ALTER TABLE [dbo].[PalabrasClaveXServicio] CHECK CONSTRAINT [FK_PalabrasClaveXServicio_Servicios]
GO
ALTER TABLE [dbo].[Paquetes]  WITH CHECK ADD  CONSTRAINT [FK_Paquetes_Proveedores] FOREIGN KEY([proveedorId])
REFERENCES [dbo].[Proveedores] ([proveedorId])
GO
ALTER TABLE [dbo].[Paquetes] CHECK CONSTRAINT [FK_Paquetes_Proveedores]
GO
ALTER TABLE [dbo].[Proveedores]  WITH CHECK ADD  CONSTRAINT [FK_Proveedores_TiposProveedores] FOREIGN KEY([idTipoProveedor])
REFERENCES [dbo].[TiposProveedores] ([idTipoProveedor])
GO
ALTER TABLE [dbo].[Proveedores] CHECK CONSTRAINT [FK_Proveedores_TiposProveedores]
GO
ALTER TABLE [dbo].[Requests]  WITH CHECK ADD  CONSTRAINT [FK_Requests_Consultas] FOREIGN KEY([consultaId])
REFERENCES [dbo].[Consultas] ([consultaId])
GO
ALTER TABLE [dbo].[Requests] CHECK CONSTRAINT [FK_Requests_Consultas]
GO
ALTER TABLE [dbo].[Requests]  WITH CHECK ADD  CONSTRAINT [FK_Requests_EstadosRequests] FOREIGN KEY([estadoRequestId])
REFERENCES [dbo].[EstadosRequests] ([estadoRequest])
GO
ALTER TABLE [dbo].[Requests] CHECK CONSTRAINT [FK_Requests_EstadosRequests]
GO
ALTER TABLE [dbo].[Requests]  WITH CHECK ADD  CONSTRAINT [FK_Requests_Servicios] FOREIGN KEY([servicioId])
REFERENCES [dbo].[Servicios] ([servicioId])
GO
ALTER TABLE [dbo].[Requests] CHECK CONSTRAINT [FK_Requests_Servicios]
GO
ALTER TABLE [dbo].[Requests]  WITH CHECK ADD  CONSTRAINT [FK_Requests_Transacciones] FOREIGN KEY([transaccionId])
REFERENCES [dbo].[Transacciones] ([transaccionId])
GO
ALTER TABLE [dbo].[Requests] CHECK CONSTRAINT [FK_Requests_Transacciones]
GO
ALTER TABLE [dbo].[Resenas]  WITH CHECK ADD  CONSTRAINT [FK_Resenas_Personas] FOREIGN KEY([personaId])
REFERENCES [dbo].[Personas] ([personaId])
GO
ALTER TABLE [dbo].[Resenas] CHECK CONSTRAINT [FK_Resenas_Personas]
GO
ALTER TABLE [dbo].[ResenasXProveedores]  WITH CHECK ADD  CONSTRAINT [FK_ResenasXProveedores_Proveedores] FOREIGN KEY([proveedorId])
REFERENCES [dbo].[Proveedores] ([proveedorId])
GO
ALTER TABLE [dbo].[ResenasXProveedores] CHECK CONSTRAINT [FK_ResenasXProveedores_Proveedores]
GO
ALTER TABLE [dbo].[ResenasXProveedores]  WITH CHECK ADD  CONSTRAINT [FK_ResenasXProveedores_Resenas] FOREIGN KEY([resenaId])
REFERENCES [dbo].[Resenas] ([resenaId])
GO
ALTER TABLE [dbo].[ResenasXProveedores] CHECK CONSTRAINT [FK_ResenasXProveedores_Resenas]
GO
ALTER TABLE [dbo].[ResenasXServicio]  WITH CHECK ADD  CONSTRAINT [FK_ResenasXServicio_Resenas] FOREIGN KEY([resenaId])
REFERENCES [dbo].[Resenas] ([resenaId])
GO
ALTER TABLE [dbo].[ResenasXServicio] CHECK CONSTRAINT [FK_ResenasXServicio_Resenas]
GO
ALTER TABLE [dbo].[ResenasXServicio]  WITH CHECK ADD  CONSTRAINT [FK_ResenasXServicio_Servicios] FOREIGN KEY([servicioId])
REFERENCES [dbo].[Servicios] ([servicioId])
GO
ALTER TABLE [dbo].[ResenasXServicio] CHECK CONSTRAINT [FK_ResenasXServicio_Servicios]
GO
ALTER TABLE [dbo].[ServiciosXProveedor]  WITH CHECK ADD  CONSTRAINT [FK_ServiciosXProveedor_Lugares] FOREIGN KEY([lugarId])
REFERENCES [dbo].[Lugares] ([lugarId])
GO
ALTER TABLE [dbo].[ServiciosXProveedor] CHECK CONSTRAINT [FK_ServiciosXProveedor_Lugares]
GO
ALTER TABLE [dbo].[ServiciosXProveedor]  WITH CHECK ADD  CONSTRAINT [FK_ServiciosXProveedor_Proveedores] FOREIGN KEY([proveedorId])
REFERENCES [dbo].[Proveedores] ([proveedorId])
GO
ALTER TABLE [dbo].[ServiciosXProveedor] CHECK CONSTRAINT [FK_ServiciosXProveedor_Proveedores]
GO
ALTER TABLE [dbo].[ServiciosXProveedor]  WITH CHECK ADD  CONSTRAINT [FK_ServiciosXProveedor_Servicios] FOREIGN KEY([servicioId])
REFERENCES [dbo].[Servicios] ([servicioId])
GO
ALTER TABLE [dbo].[ServiciosXProveedor] CHECK CONSTRAINT [FK_ServiciosXProveedor_Servicios]
GO
ALTER TABLE [dbo].[Transacciones]  WITH CHECK ADD  CONSTRAINT [FK_Transacciones_Personas] FOREIGN KEY([personaId])
REFERENCES [dbo].[Personas] ([personaId])
GO
ALTER TABLE [dbo].[Transacciones] CHECK CONSTRAINT [FK_Transacciones_Personas]
GO
ALTER TABLE [dbo].[Transacciones]  WITH CHECK ADD  CONSTRAINT [FK_Transacciones_Proveedores] FOREIGN KEY([proveedorId])
REFERENCES [dbo].[Proveedores] ([proveedorId])
GO
ALTER TABLE [dbo].[Transacciones] CHECK CONSTRAINT [FK_Transacciones_Proveedores]
GO
ALTER TABLE [dbo].[Transacciones]  WITH CHECK ADD  CONSTRAINT [FK_Transacciones_Wallets] FOREIGN KEY([walletId])
REFERENCES [dbo].[Wallets] ([walletId])
GO
ALTER TABLE [dbo].[Transacciones] CHECK CONSTRAINT [FK_Transacciones_Wallets]
GO
ALTER TABLE [dbo].[Wallets]  WITH CHECK ADD  CONSTRAINT [FK_Wallets_EmpresasWallets] FOREIGN KEY([empresaWalletId])
REFERENCES [dbo].[EmpresasWallets] ([empresaWalletId])
GO
ALTER TABLE [dbo].[Wallets] CHECK CONSTRAINT [FK_Wallets_EmpresasWallets]
GO
ALTER TABLE [dbo].[Wallets]  WITH CHECK ADD  CONSTRAINT [FK_Wallets_Personas] FOREIGN KEY([personaId])
REFERENCES [dbo].[Personas] ([personaId])
GO
ALTER TABLE [dbo].[Wallets] CHECK CONSTRAINT [FK_Wallets_Personas]
GO
USE [master]
GO
ALTER DATABASE [Caso4] SET  READ_WRITE 
GO
