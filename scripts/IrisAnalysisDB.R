source('scripts\\includes\\functions.R', chdir = TRUE)

addPackage("RODBC")

connection <- RODBC::odbcConnect("LOCALHOST")

try(RODBC::sqlDrop(connection, "dbo.iris", errors = FALSE), silent = TRUE)

sqlSave(connection, iris)

RODBC::odbcClose(connection)
