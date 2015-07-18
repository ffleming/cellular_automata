#include <ruby.h>
#include <stdio.h>

VALUE CellularC = Qnil;
void Init_cellular_c();
VALUE method_neighbor_population_of(VALUE, VALUE, VALUE, VALUE);

void Init_cellular_c() {
  CellularC = rb_define_module("CellularC");
  rb_define_singleton_method(CellularC, "neighbor_population_of", method_neighbor_population_of, 3);
}

VALUE method_neighbor_population_of(VALUE self, VALUE state, VALUE rx, VALUE ry) {
  int height = RARRAY_LEN(state);
  int width  = RARRAY_LEN(rb_ary_entry(state, 0));
  int x = FIX2INT(rx);
  int y = FIX2INT(ry);
  int min_x = x > 1 ? x - 1 : 0;
  int max_x = x < width - 2 ? x + 1 : width - 1;
  int min_y = y > 1 ? y - 1 : 0;
  int max_y = y < height - 2 ? y + 1 : height - 1;
  int ret = 0;

  for(int row = min_y; row <= max_y; row++) {
      VALUE row_array = rb_ary_entry(state, row);
      for(int col = min_x; col <= max_x; col++) {
          int alive = FIX2INT(rb_ary_entry(row_array, col));
          if((alive == 1) && ((x != col) || (y != row))) {
              ret += 1;
          }
      }
  }
  return(INT2FIX(ret));
}
