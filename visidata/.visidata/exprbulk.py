from visidata import BaseSheet, Sheet, ExprColumn, vd, EscapeException
from visidata.expr import CompleteExpr


@Sheet.api
def addcol_expr_bulk(sheet):
    expr = vd.input("columns exprs=", "expr", completer=CompleteExpr(sheet))
    oldidx = sheet.cursorVisibleColIndex

    for n in range(1, int(vd.input("add columns: ")) + 1):
        try:
            c = sheet.addColumnAtCursor(ExprColumn(
                str(n), expr, width=sheet.options.default_width))
            sheet.cursorVisibleColIndex = sheet.visibleCols.index(c)

            c.width = None
        except (Exception, EscapeException):
            if c is not None:
                sheet.columns.remove(c)
            sheet.cursorVisibleColIndex = oldidx
            raise


BaseSheet.addCommand('gzz=', 'addcol-bulkexpr', 'sheet.addcol_expr_bulk()',
                     'append N columns by Python expression')
