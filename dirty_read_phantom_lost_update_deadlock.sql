-- Dirty Read

-- Transaccion 1

-- Usuario deja una resena pero por accidente da una nota de 3 cuando en verdad queria dar una nota de 4, el usuario entra al sistema a editar su resena, pero cuando el usuario
-- del servicio revisa pierde la conexion entonces la transacci�n falla y se hace rollback, antes del rollback el proveedor consulta esa resena y ve la calificion actualizada y
-- despues consulta de nuevo ve la calificacion vieja. 
CREATE OR ALTER PROCEDURE SP_ActualizarCalificacionResena
@resenaId SMALLINT,
@calificacion TINYINT
AS
BEGIN
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRANSACTION
    UPDATE dbo.Resenas SET dbo.Resenas.calificacion = @calificacion WHERE resenaId = @resenaId

    WAITFOR DELAY '00:00:05'
    -- CORRER SP_BuscarResenaPorID  DURANTE EL TIEMPO DE ESPERA

    ROLLBACK
END;
GO

-- Transaccion 2
CREATE OR ALTER PROCEDURE SP_BuscarResenaPorID
@resenaId SMALLINT
AS
BEGIN
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
select * from Resenas WHERE resenaId=@resenaId; --ejecucion del dirty read
END;
GO

-- EJECUCION Dirty Read
-- Sesion 1
EXEC SP_ActualizarCalificacionResena @resenaId = 2, @calificacion = 4;
GO
-- Sesion 2 (ejecutar durante tiempo de espera de SP_ActualizarCalificacionResena)
EXEC SP_BuscarResenaPorID @resenaId = 2;
GO

-- Solucion - Dirty Read

-- Se cambia el nivel de isolacion de la transaccion 1 y 2 a Read Committed

-- Transaccion 1
CREATE OR ALTER PROCEDURE SP_ActualizarCalificacionResenaSolucion
@resenaId SMALLINT,
@calificacion TINYINT
AS
BEGIN
SET TRANSACTION ISOLATION LEVEL READ COMMITTED -- con esto se hace un lock a la fila, y no permite hacer el read de la segunda instancia
BEGIN TRANSACTION
    UPDATE dbo.Resenas SET dbo.Resenas.calificacion = @calificacion WHERE resenaId = @resenaId

    WAITFOR DELAY '00:00:05'
    -- CORRER SP_BuscarResenaPorID  DURANTE EL TIEMPO DE ESPERA
    ROLLBACK
END;
GO

-- Transaccion 2
CREATE OR ALTER PROCEDURE SP_BuscarResenaPorIDSolucion
@resenaId SMALLINT
AS
BEGIN
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
select * from Resenas WHERE resenaId=@resenaId; --ejecucion del dirty read
END;
GO

-- EJECUCION - Solucion Dirty Read
-- Sesion 1
EXEC SP_ActualizarCalificacionResenaSolucion @resenaId = 2, @calificacion = 4;
GO
-- Sesion 2 (ejecutar durante tiempo de espera de SP_ActualizarCalificacionResenaSolucion)
EXEC SP_BuscarResenaPorIDSolucion @resenaId = 2;
GO

-- Phantom read
-- El proveedor consulta qu� contratos tiene mientras que un administrador al mismo tiempo est� insertando un nuevo contrato a ese proveedor,
-- el proveedor consulta lo mismo de nuevo y ve que de la nada le sali� otro contrato

-- Transaction 1

CREATE OR ALTER PROCEDURE SP_ListarContratosYCantidad
@proveedorId INT
AS
BEGIN
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRANSACTION
DECLARE @Cantidad AS INT
SET @Cantidad = 0;
SELECT @Cantidad = COUNT(*) FROM Contratos where proveedorId = @proveedorId;
SELECT @Cantidad AS CantidadContratos
-- Mientras esta el delay, corra la transaccion 2
WAITFOR DELAY '00:00:05'
SELECT * FROM Contratos where proveedorId = @proveedorId
COMMIT TRANSACTION
END;
GO

-- Transaction 2
CREATE OR ALTER PROCEDURE SP_CrearContrato
@proveedorId INT,
@fechaInicio DATE,
@fechaExpiración DATE
AS
BEGIN
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRANSACTION
INSERT into Contratos VALUES(@proveedorId, @fechaInicio, @fechaExpiración)
COMMIT TRANSACTION
END;
GO

-- EJECUCION Phantom Read

-- Sesion 1

EXEC SP_ListarContratosYCantidad @proveedorId = 1;
GO

-- Sesion 2 (ejecutar durante tiempo de espera de SP_ListarContratosYCantidad)

EXEC SP_CrearContrato @proveedorId = 1, @fechaInicio = '2022-11-11', @fechaExpiración = '2023-11-11'
GO

-- Solucion - Phantom Read
-- Se le pone el nivel de isolaci�n a la primera y segunda transacci�n como serializable, con esto la transaccion 2 esperara 
-- hasta que esa primera transaccion termine para insertar el nuevo contrato, por lo tanto, la cantidad de contratos
-- va a coincidir con la cantidad de contratos que se listan


-- Transaction 1

CREATE OR ALTER PROCEDURE SP_ListarContratosYCantidadSolucion
@proveedorId INT
AS
BEGIN
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE 
BEGIN TRANSACTION
DECLARE @Cantidad AS INT
SET @Cantidad = 0;
SELECT @Cantidad = COUNT(*) FROM Contratos where proveedorId = @proveedorId;
SELECT @Cantidad AS CantidadContratos
-- Mientras esta el delay, corra la transaccion 2
WAITFOR DELAY '00:00:05'
SELECT * FROM Contratos where proveedorId = @proveedorId
COMMIT TRANSACTION
END;
GO

-- Transaction 2
CREATE OR ALTER PROCEDURE SP_CrearContratoSolucion
@proveedorId INT,
@fechaInicio DATE,
@fechaExpiración DATE
AS
BEGIN
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRANSACTION
INSERT into Contratos VALUES(@proveedorId, @fechaInicio, @fechaExpiración)
COMMIT TRANSACTION
END;
GO


-- EJECUCION - Solucion Phantom Read

-- Sesion 1
EXEC SP_ListarContratosYCantidadSolucion @proveedorId = 1;
GO

-- Sesion 2 (ejecutar durante tiempo de espera de SP_ListarContratosYCantidadSolucion)

EXEC SP_CrearContratoSolucion @proveedorId = 1, @fechaInicio = '2022-11-11', @fechaExpiración = '2023-11-11'
GO



-- Lost Update

-- Dos administradores fueron contactados por proveedores ya que desean aumentar el precio de uno de sus servicios el proveedor le dice al primer administrador que desea incrementar
-- el precio del servicio de limpieza de alfombras a 75, despues de esto le dice a otro administrador que se equivoco y que deseaba actualizarlo por 25. Ambos administradores 
-- tratan de actualizar el precio a lo que se les dijo creando un Lost Update.

CREATE OR ALTER PROCEDURE SP_UpdateServicioPrecio
@nuevoPrecio smallint,
@servicioId smallint
AS
BEGIN
  BEGIN TRANSACTION
  SELECT * FROM Servicios WHERE servicioId=@servicioId
  -- Transaction toma 5 segundos
  WAITFOR DELAY '00:00:05'
  UPDATE dbo.Servicios SET dbo.Servicios.precio = @nuevoPrecio WHERE servicioId = @servicioId
  SELECT precio FROM Servicios WHERE servicioId = @servicioId
  COMMIT TRANSACTION
END;
GO

-- EJECUCION
-- Sesion 1
EXEC SP_UpdateServicioPrecio @nuevoPrecio = 25, @servicioId = 1;
GO
-- Sesion 2 (ejecutar durante tiempo de espera de SP_UpdateServicioPrecioTo25)
EXEC SP_UpdateServicioPrecio @nuevoPrecio = 75,@servicioId = 1;
GO

-- SOLUCION - Lost Update

-- Procedimiento almacenado para Transaction 1
CREATE OR ALTER PROCEDURE SP_UpdateServicioPrecioSerializable
@nuevoPrecio smallint,
@servicioId smallint
AS
BEGIN
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRANSACTION
SELECT * FROM Servicios WHERE servicioId=@servicioId
-- Transaction toma 5 segundos
WAITFOR DELAY '00:00:05'
UPDATE dbo.Servicios SET dbo.Servicios.precio = @nuevoPrecio WHERE servicioId = @servicioId
SELECT precio FROM Servicios WHERE servicioId = @servicioId
COMMIT TRANSACTION
END;
GO

-- EJECUCION - Solucion Lost Update
-- Sesion 1
EXEC SP_UpdateServicioPrecioSerializable @nuevoPrecio = 75, @servicioId = 1;
GO
-- Sesion 2 (ejecutar durante tiempo de espera de SP_UpdateServicioPrecioTo25)
EXEC SP_UpdateServicioPrecioSerializable @nuevoPrecio = 25,@servicioId = 1;
GO


-- Deadlocks

-- Se desea actualizar una resena puesta por una persona, al mismo tiempo se desea actualizar el nombre de la persona que puso esa resena 

-- Transaccion 1

CREATE OR ALTER PROCEDURE SP_CambiarResena
    @resenaId INT,
    @calificacion INT,
    @personaId INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRANSACTION;
        UPDATE dbo.Resenas SET dbo.Resenas.calificacion = @calificacion WHERE resenaId = @resenaId;
        WAITFOR DELAY '00:00:05';
        SELECT * FROM Personas WHERE personaId = @personaId;
    COMMIT;
END;
GO

-- Transaccion 2

CREATE OR ALTER PROCEDURE SP_CambiarNombre
    @personaId INT,
    @nuevoNombre NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRANSACTION;
        UPDATE dbo.Personas SET dbo.Personas.nombre = @nuevoNombre WHERE personaId = @personaId;
        WAITFOR DELAY '00:00:10';
        SELECT * FROM Resenas WHERE personaId = @personaId;
    COMMIT;
END;
GO

-- EJECUCION - Deadlock

-- Sesion 1
EXEC SP_CambiarResena @resenaId = 2,@calificacion = 4, @personaId = 1;
GO

-- Sesion 2 (ejecutar durante tiempo de espera de SP_CambiarResena)
EXEC SP_CambiarNombre @personaId = 1, @nuevoNombre = 'Camilo';
GO


-- Solucion - Deadlock
-- Debido a que, el manejo de deadlocks es sumamente complejo, se deben tener en cuenta muchos factores, uno de ellos es el orden de acceso a las tablas.
-- En este caso, los procedures no solucion, las transacciones acceden a las mismas tablas, pero en orden inverso, lo primero que se hará para solucionar
-- será hacer que ambas tablas se accedan en el mismo orden.
-- Implicado esto, se agrega una línea antes de la transaccion de isolacion serializable, para evitar updates de columnas en uso.


-- Transaccion 1

CREATE OR ALTER PROCEDURE SP_CambiarResenaSolucion
    @resenaId INT,
    @calificacion INT,
    @personaId INT
AS
BEGIN
    SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

    BEGIN TRANSACTION;
        UPDATE dbo.Resenas SET dbo.Resenas.calificacion = @calificacion WHERE resenaId = @resenaId;
        WAITFOR DELAY '00:00:05';
        SELECT * FROM Personas WHERE personaId = @personaId;
    COMMIT;
END;
GO

CREATE OR ALTER PROCEDURE SP_CambiarNombreSolucion
    @personaId INT,
    @nuevoNombre NVARCHAR(50)
AS
BEGIN
    SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

    BEGIN TRANSACTION;
        SELECT * FROM Resenas WHERE personaId = @personaId;
        WAITFOR DELAY '00:00:05';
        UPDATE dbo.Personas SET dbo.Personas.nombre = @nuevoNombre WHERE personaId = @personaId;
        
        
    COMMIT;
END;

GO
-- EJECUCION - Solucion Deadlock 

-- Sesion 1
EXEC SP_CambiarResenaSolucion @resenaId = 2,@calificacion = 4, @personaId = 1;
GO

-- Sesion 2 (ejecutar durante tiempo de espera de SP_CambiarResena)
EXEC SP_CambiarNombreSolucion @personaId = 1, @nuevoNombre = 'Camilo';
GO