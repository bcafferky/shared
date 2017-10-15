Function GenericSqlQuery
{
        $Datatable = New-Object System.Data.DataTable
        $Connection = New-Object System.Data.SQLClient.SQLConnection
        $Connection.ConnectionString = "Server=localhost;Trusted_Connection=True;Connection Timeout=30;"
        $connection.Open()
        $Command = New-Object System.Data.SQLClient.SQLCommand
        $Command.Connection = $Connection
        $Command.CommandText = "Select @@servername as name" <# for example #>
        $DataAdapter = new-object System.Data.SqlClient.SqlDataAdapter $Command
        $DataAdapter.SelectCommand.CommandTimeout = 600
        $Dataset = new-object System.Data.Dataset
        [void]$DataAdapter.Fill($Dataset)
        return $Dataset.tables[0]
}

# GenericSqlQuery

