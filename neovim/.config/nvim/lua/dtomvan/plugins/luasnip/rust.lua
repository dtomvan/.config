local function ok_if_result(index)
    return f(function(arg)
        if arg[1][1]:match 'Result' then
            return 'Ok(())'
        else
            return ''
        end
    end, { index })
end

return {
    s('enum', {
        t { '#[derive(Debug, Clone, Copy)]', 'enum ' },
        i(1, 'Name'),
        t { ' {', '    ' },
        i(0),
        t { '', '}' },
    }),
    s(
        'test',
        fmt(
            [[
#[test]
fn {}() {{
    {}
}}
]],
            { i(1, { 'it_works' }), i(2) }
        )
    ),
    s(
        'modtest',
        fmt(
            [[
#[cfg(test)]
mod test {{
    use super::*;
    {}
}}
]],
            i(0)
        )
    ),
    s(
        'main',
        fmta(
            [[fn main() <>{
    <>
    <>
}]],
            {
                c(1, {
                    t '',
                    t '-> std::result::Result<(), Box<dyn std::error::Error>>',
                    t '-> Result<()>',
                }),
                i(2),
                ok_if_result(1),
            }
        )
    ),
}, { key = 'rust' }
