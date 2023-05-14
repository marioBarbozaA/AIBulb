USE [Caso4]
GO

INSERT INTO [dbo].[Cargos]
           ([tipoCargoId]
           ,[precio]
           ,[descripcion])
     VALUES
           (1, 10, 'Impuesto sobre ventas'),
		   (2, 5, 'Impuesto sobre la renta'),
		   (1, 7, 'Impuesto municipal');
GO

USE [Caso4]
GO

INSERT INTO [dbo].[Lugares]
           ([nombre]
           ,[levelParent])
     VALUES
		('Ciudad de México', NULL),
		('Álvaro Obregón', 1),
		('Azcapotzalco', 1),
		('Benito Juárez', 1),
		('Coyoacán', 1),
		('Cuajimalpa', 1),
		('Cuauhtémoc', 1),
		('Gustavo A. Madero', 1),
		('Iztacalco', 1),
		('Iztapalapa', 1),
		('Magdalena Contreras', 1),
		('Miguel Hidalgo', 1),
		('Milpa Alta', 1),
		('Tláhuac', 1),
		('Tlalpan', 1),
		('Venustiano Carranza', 1),
		('Xochimilco', 1),
		('Santa Fe', 2),
		('San Angel', 2),
		('Polanco', 2),
		('Condesa', 2),
		('Roma', 2),
		('Centro Histórico', 2);
GO

USE [Caso4]
GO

INSERT INTO [dbo].[CargosXLugar]
           ([CargoId]
           ,[lugarId]
           ,[estado])
     VALUES
		(1, 1, 1),
		(1, 2, 1),
		(1, 3, 0),
		(2, 1, 1),
		(2, 2, 0),
		(2, 3, 1);
GO

USE [Caso4]
GO

INSERT INTO [dbo].[Categorías]
           ([nombre]
           ,[descripcion])
     VALUES
	   ('Electrónica', 'Productos electrónicos para el hogar'),
       ('Ropa', 'Prendas de vestir para hombres y mujeres'),
       ('Hogar', 'Artículos para el hogar'),
       ('Juguetes', 'Juguetes para niños de todas las edades');
GO

USE [Caso4]
GO

INSERT INTO [dbo].[CategoriasXServicio]
           ([servicioId]
           ,[categoriaId])
     VALUES
           (1, 3),
		   (1, 5),
		   (2, 1),
		   (3, 2),
		   (3, 5);
GO

USE [Caso4]
GO

INSERT INTO [dbo].[Consultas]
           ([contenido]
           ,[fecha]
           ,[personaId])
     VALUES
           ('¿Cuáles son los requisitos para obtener un préstamo?', '2022-05-01 10:30:00', 12345),
           ('Quiero solicitar una tarjeta de crédito, ¿qué necesito?', '2022-05-02 15:45:00', 67890),
           ('¿Cómo puedo revisar mi estado de cuenta en línea?', '2022-05-03 08:00:00', 23456);
GO

USE [Caso4]
GO

INSERT INTO [dbo].[Contratos]
           ([proveedorId]
           ,[fechaInicio]
           ,[fechaExpiración])
     VALUES
           (1, '2022-01-01', '2023-01-01'),
           (2, '2021-06-01', '2023-06-01'),
           (3, '2023-01-01', '2024-01-01');
GO

USE [Caso4]
GO

INSERT INTO [dbo].[EmpresasWallets]
           ([nombre])
     VALUES
           ('Empresa A'),
		   ('Empresa B'),
		   ('Empresa C');
GO

USE [Caso4]
GO

INSERT INTO [dbo].[EstadosRequests]
           ([nombre]
           ,[descripcion])
     VALUES
           ('En Espera','El request está en espera de ser procesado'),
           ('Procesado','El request ha sido procesado exitosamente'),
		   ('Rechazado','El request ha sido rechazado por el sistema');
GO

USE [Caso4]
GO

INSERT INTO [dbo].[Leyes]
           ([codigo]
           ,[articulo]
           ,[nombre]
           ,[descripcion]
           ,[tipoLeyId]
           ,[precio])
     VALUES
           ('L001','Art. 1','Ley de Protección de Datos Personales','Esta ley tiene como objetivo proteger los datos personales de los ciudadanos.',1,10.50),
           ('L002','Art. 3','Ley de Protección al Consumidor','Esta ley tiene como objetivo proteger los derechos de los consumidores.',1,15.75),
           ('L003','Art. 2','Ley de Propiedad Intelectual','Esta ley tiene como objetivo proteger la propiedad intelectual de las personas y empresas.',2,20.00)
GO

USE [Caso4]
GO

INSERT INTO [dbo].[LeyesXLugar]
           ([leyId]
           ,[lugarId]
           ,[vigente])
     VALUES
            (1, 1, 1)
           ,(2, 1, 0)
           ,(3, 2, 1)
           ,(4, 3, 1)
           ,(5, 3, 0)
GO

USE [Caso4]
GO

INSERT INTO [dbo].[Localizaciones]
           ([direccion]
           ,[codigoZip]
           ,[borrado]
           ,[lugarId])
     VALUES
           (geography::Point(47.6204, -122.3491, 4326),'98101',0,1),
		   (geography::Point(47.6149, -122.1949, 4326), '98109', 0, 1),
		   (geography::Point(40.7128, -74.0060, 4326), '10007', 0, 2),
		   (geography::Point(37.7749, -122.4194, 4326), '94102', 0, 3);
GO

USE [Caso4]
GO

INSERT INTO [dbo].[LocalizacionesXPersonas]
           ([personaId]
           ,[localizacionId]
           ,[actual])
     VALUES
           (1,1,1),
		   (2,2,0),
		   (3,1,0);
GO

USE [Caso4]
GO

INSERT INTO [dbo].[LocalizacionesXProveedor]
           ([proveedorId]
           ,[localizacionId]
           ,[actual])
     VALUES
           (1,2,1),
		   (2,3,1),
		   (3,1,1),
		   (4,4,1),
		   (5,2,1);
GO


USE [Caso4]
GO

INSERT INTO [dbo].[LugaresXContrato]
           ([contratoId]
           ,[lugarId])
     VALUES
           (1, 2),
		   (1, 5),
		   (2, 3),
		   (2, 6);
GO

USE [Caso4]
GO

INSERT INTO [dbo].[Modelos]
           ([nombre]
           ,[descripcion])
     VALUES
           ('Suscripción Mensual','Pago mensual por uso continuado del servicio.'),
		   ('Pago por Uso','Cobro por cada transacción realizada.'),
		   ('Pago por Descarga','Cobro por la descarga de contenido o información.');
GO

USE [Caso4]
GO

INSERT INTO [dbo].[ModelosXServicio]
           ([modeloId]
           ,[servicioId])
     VALUES
           (1,3),
		   (2,1),
		   (3,2),
		   (1,4),
		   (2,6);
GO

USE [Caso4]
GO

INSERT INTO [dbo].[PalabrasClave]
           ([palabra])
     VALUES
           ('reparación'),
           ('mantenimiento'),
           ('instalación'),
           ('fontanería'),
           ('electricidad'),
           ('limpieza'),
           ('jardinería'),
           ('pintura');
GO

USE [Caso4]
GO

INSERT INTO [dbo].[PalabrasClaveXServicio]
           ([palabraClaveId]
           ,[servicioId])
     VALUES
			(1, 2),
			(3, 1),
			(2, 3),
			(1, 4),
			(4, 3),
			(5, 2),
			(2, 4),
			(3, 2),
			(5, 1),
			(4, 4);
GO

USE [Caso4]
GO

INSERT INTO [dbo].[Paquetes]
           ([planesGratis]
           ,[planesPagas]
           ,[descripcion]
           ,[proveedorId])
     VALUES
			(0, 5, 'Paquete Básico de 5 planes pagos', 10),
			(2, 0, 'Paquete Gratis con 2 planes gratuitos', 8),
			(3, 3, 'Paquete Mixto con 3 planes gratuitos y 3 planes pagos', 14);
GO

USE [Caso4]
GO

INSERT INTO [dbo].[Personas]
           ([nombre]
           ,[apellido]
           ,[email]
           ,[domicilio])
     VALUES
           ('Juan', 'Pérez', 'juan.perez@example.com', 'POINT(-34.603722,-58.381592)'),
           ('María', 'González', 'maria.gonzalez@example.com', 'POINT(-34.603722,-58.381592)'),
           ('Pedro', 'Gómez', 'pedro.gomez@example.com', 'POINT(-34.603722,-58.381592)'),
           ('Laura', 'Rodríguez', 'laura.rodriguez@example.com', 'POINT(-34.603722,-58.381592)'),
           ('Federico', 'Fernández', 'federico.fernandez@example.com', 'POINT(-34.603722,-58.381592)');
GO

USE [Caso4]
GO

INSERT INTO [dbo].[Proveedores]
           ([nombre]
           ,[idTipoProveedor])
     VALUES
       ('Netflix', 1),
       ('Spotify', 2),
       ('CarinosasAlRescate', 3)
GO

USE [Caso4]
GO

INSERT INTO [dbo].[Requests]
           ([consultaId]
           ,[servicioId]
           ,[transaccionId]
           ,[estadoRequestId]
           ,[fecha])
     VALUES
           (1,1,1,1,'2023-05-11 10:30:00'),
		   (1,2,3,2,'2022-05-10 09:17:45')
GO

USE [Caso4]
GO

INSERT INTO [dbo].[Resenas]
           ([personaId]
           ,[contenido]
           ,[calificacion]
           ,[fecha])
     VALUES
			(1,'El servicio fue excelente. Los profesionales que brindaron el servicio fueron muy amables y resolvieron mis dudas con prontitud.',5,'2022-05-10 14:30:00'),
			(2,'El servicio fue satisfactorio, aunque hubo algunos problemas de comunicación con el proveedor.',3,'2022-05-09 10:45:00'),
			(3,'No recomendaría este servicio, ya que tuve una experiencia muy mala con el proveedor. No fueron profesionales y tardaron demasiado en resolver mi problema.',1,'2022-05-08 16:20:00');
GO

USE [Caso4]
GO

INSERT INTO [dbo].[ResenasXProveedores]
           ([resenaId]
           ,[proveedorId])
     VALUES
           (1, 1),
           (2, 2),
           (3, 3);
GO

USE [Caso4]
GO

INSERT INTO [dbo].[ResenasXServicio]
           ([resenaId]
           ,[servicioId])
     VALUES
           (1, 1),
           (2, 2),
           (3, 3);
GO

USE [Caso4]
GO

INSERT INTO [dbo].[Servicios]
           ([nombre]
           ,[descripcion]
           ,[precio])
     VALUES
       ('Limpieza de alfombras','Servicio de limpieza de alfombras a domicilio',50.00),
	   ('Corte de cabello','Corte de cabello para hombres y mujeres',25.00),
	   ('Masaje terapéutico','Masaje relajante y terapéutico',80.00),
	   ('Servicio de limpieza de hogar','Servicio de limpieza de hogar completo',100.00)

GO

USE [Caso4]
GO


INSERT INTO [dbo].[ServiciosXProveedor]
           ([proveedorId]
           ,[servicioId]
           ,[lugarId])
     VALUES
           (1, 2, 3),
           (2, 1, 2),
           (3, 3, 1),
           (4, 4, 2),
           (5, 2, 3);
GO

USE [Caso4]
GO

INSERT INTO [dbo].[TipoCargos]
           ([nombre])
     VALUES
            ('IVA'),
			('Impuesto de sociedades'),
			('Impuesto a las ganancias'),
			('Impuesto a la renta'),
			('Impuesto al valor de la propiedad'),
			('Impuesto al consumo'),
			('Impuesto sobre la nómina'),
			('Impuesto de lujo'),
			('Impuesto de timbre'),
			('Impuesto al turismo');
GO

USE [Caso4]
GO

INSERT INTO [dbo].[TiposLeyes]
           ([nombre])
     VALUES
           ('Ley 1'),
           ('Ley 2'),
           ('Ley 3'),
           ('Ley 4'),
           ('Ley 5');
GO

USE [Caso4]
GO

INSERT INTO [dbo].[TiposProveedores]
           ([nombre]
           ,[descripcion])
     VALUES
            ('Proveedor de servicios de limpieza', 'Ofrece servicios de limpieza para empresas y hogares.')
			,('Proveedor de servicios de seguridad', 'Ofrece servicios de seguridad para empresas y eventos.')
			,('Proveedor de servicios de tecnología', 'Ofrece servicios de desarrollo de software y hardware para empresas.')
			,('Proveedor de servicios de alimentos', 'Ofrece servicios de catering para eventos y empresas.')
			,('Proveedor de servicios de transporte', 'Ofrece servicios de transporte de carga y paquetería.')
GO

USE [Caso4]
GO

INSERT INTO [dbo].[Transacciones]
           ([fecha]
           ,[total]
           ,[descripcion]
           ,[numeroReferencia]
           ,[nombreComputadora]
           ,[IP]
           ,[walletId]
           ,[idTransaccionWallet]
           ,[personaId]
           ,[proveedorId])
     VALUES
           ('2022-01-15 08:45:00',112.50,'Compra de productos electrónicos','REF-123456','LAPTOP-JK123',19216811,3 ,'TXN-567890',2,1),
		   ('2022-03-28 14:30:00',65.00,'Pago de servicios de internet','REF-654321','PC-MAC123',17216812,5,'TXN-123456',3,4),
		   ('2022-05-02 11:15:00',250.00,'Pago de servicios de energía eléctrica','REF-098765','DESKTOP-PC01',19216812,2,'TXN-678901',1,6)
GO

USE [Caso4]
GO

INSERT INTO [dbo].[Wallets]
           ([nombre]
           ,[identificador]
           ,[empresaWalletId]
           ,[personaId])
     VALUES
			('Wallet1','w112233',1,1),
           ('Wallet2','w445566',2,2),
           ('Wallet3','w778899',1,3),
           ('Wallet4','w123456',3,4),
           ('Wallet5','w789101',2,1),
           ('Wallet6','w111213',3,2),
           ('Wallet7','w141516',1,3),
           ('Wallet8','w171819',2,4),
           ('Wallet9','w202122',3,1),
           ('Wallet10','w232425',1,2);
GO

































