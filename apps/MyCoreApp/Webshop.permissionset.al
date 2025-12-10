permissionset 50100 Webshop
{
    Assignable = true;
    Permissions = tabledata "DEF Webshop Header Staging TDY"=RIMD,
        tabledata "DEF Webshop Line Staging TDY"=RIMD,
        table "DEF Webshop Header Staging TDY"=X,
        table "DEF Webshop Line Staging TDY"=X,
        page "DEF Webshop Header Card"=X,
        page "DEF Webshop Header List"=X,
        page "DEF Webshop Lines Part"=X;
}