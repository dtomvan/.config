import re

from visidata import BaseSheet, Column


@Column.api
def change_precision(col, amount: int):
    if col.type == float:
        if col.fmtstr == '':
            col.fmtstr = f'%.{2 + amount}f'
        else:
            precision_str = re.match(r'%.([0-9]+)f', col.fmtstr)
            if not precision_str is None:
                col.fmtstr = f'%.{max(0, int(precision_str[1]) + amount)}f'
    else:
        col.type = float
        if col.fmtstr == '':
            col.fmtstr = '%.2f'

BaseSheet.addCommand('Alt+-', 'precision-less', 'cursorCol.change_precision(-1)')
BaseSheet.addCommand('Alt++', 'precision-more', 'cursorCol.change_precision(1)')
