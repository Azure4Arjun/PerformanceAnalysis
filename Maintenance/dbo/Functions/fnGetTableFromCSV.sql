﻿CREATE   FUNCTION [dbo].[fnGetTableFromCSV](@STRING VARCHAR(8000))
RETURNS @TABLE TABLE
(
	ID int,
	item varchar(8000)
)
AS
BEGIN

 DECLARE @I INT
 DECLARE @COMMA INT	
 SET @I = 0	

 IF @STRING <> ''
 BEGIN
	SET @STRING = LTRIM(RTRIM(@STRING))

	SET @COMMA = PATINDEX('%,',@STRING)
	IF @COMMA = LEN(@STRING)
		SET @STRING = LEFT(@STRING, @COMMA -1)
	SET @COMMA = PATINDEX (',%',@STRING)
	IF @COMMA = 1
		SET @STRING = RIGHT (@STRING, LEN(@STRING) - 1)
	SET @COMMA = 1	
	
		WHILE (@COMMA >0)
		BEGIN			
			SET @COMMA = PATINDEX('%,%',@STRING)		
	
			IF (@COMMA <> 0)			 			
				INSERT INTO @TABLE
				SELECT @I, LEFT(@STRING, @COMMA -1)	
			ELSE		
				INSERT INTO @TABLE
				SELECT @I, @STRING
	
			IF (LEN(@STRING)- @COMMA) >= 0			
				SET @STRING = RIGHT(@STRING, LEN(@STRING) - @COMMA)
			ELSE
			   	SET @COMMA = 0		
	
			SET @I = @I + 1
		END
 END


	
RETURN 
END	