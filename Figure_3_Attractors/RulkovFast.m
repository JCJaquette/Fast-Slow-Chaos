function x_out = Rulkov_Map( alpha, x, y)

F= alpha ./ ( 1 + x.^2 ) + y ;

x_out = F;

end

