#include <ruby.h>
#include <stdio.h>

VALUE CellularC = Qnil;
void Init_cellular_c();
VALUE method_neighbor_population_of(VALUE, VALUE, VALUE, VALUE);
VALUE method_dup_state(VALUE, VALUE);
VALUE method_tick(VALUE, VALUE);

void Init_cellular_c() {
  CellularC = rb_define_module("CellularC");
  rb_define_singleton_method(CellularC, "neighbor_population_of", method_neighbor_population_of, 3);
  rb_define_singleton_method(CellularC, "dup_state", method_dup_state, 1);
}

VALUE method_dup_state(VALUE self, VALUE state) {
  int height = (int)RARRAY_LEN(state);
  int width  = (int)RARRAY_LEN(rb_ary_entry(state, 0));
  VALUE dup =  rb_ary_new2(height);
  for(int y = 0; y < height; y++) {
    VALUE row = rb_ary_new2(width);
    for(int x = 0; x < width; x++) {
      VALUE val = rb_ary_entry(row, x);
      rb_ary_push(row, val);
    }
    rb_ary_push(dup, row);
  }
  return dup;
}

VALUE method_neighbor_population_of(VALUE self, VALUE state, VALUE rx, VALUE ry) {
  int height = (int)RARRAY_LEN(state);
  int width  = (int)RARRAY_LEN(rb_ary_entry(state, 0));
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
