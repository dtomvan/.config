function R(pack, to_call, ...)
    if pack ~= nil then
        package.loaded[pack] = nil
        if to_call ~= nil then
            if ... ~= nil then
                return require(pack)[to_call](args)
            end
            return require(pack)[to_call]()
        end
        return require(pack)
    end
end
