#include <ruby.h>
#include <stdio.h>

VALUE CellularC = Qnil;
void Init_cellular_c();
int cell_value(VALUE, int);
int neighbor_population_of(VALUE, int, int);
VALUE method_dup_state(VALUE, VALUE);
VALUE method_next_state(VALUE, VALUE, VALUE);

void Init_cellular_c() {
    CellularC = rb_define_module("CellularC");
    rb_define_singleton_method(CellularC, "dup_state", method_dup_state, 1);
    rb_define_singleton_method(CellularC, "next_state", method_next_state, 2);
}

int cell_value(VALUE rule, int num_neighbors) {
    VALUE symbol_hash = rb_iv_get(rule, "@rule_hash");
    VALUE result = rb_hash_aref(symbol_hash, INT2FIX(num_neighbors));
    VALUE live = ID2SYM(rb_intern("live!"));
    VALUE die = ID2SYM(rb_intern("die!"));
    if(result == die) {
        return 0;
    } else if(result == live) {
        return 1;
    }
    return -1;
}

int neighbor_population_of(VALUE state, int x, int y) {
    int height = (int)RARRAY_LEN(state);
    int width  = (int)RARRAY_LEN(rb_ary_entry(state, 0));
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
    return ret;
}

VALUE method_next_state(VALUE self, VALUE state, VALUE rule) {
  VALUE next_state = method_dup_state(self, state);
  int height = (int)RARRAY_LEN(state);
  int width  = (int)RARRAY_LEN(rb_ary_entry(state, 0));
  for(int row = 0; row < height; row++) {
      VALUE row_array = rb_ary_entry(next_state, row);
      for(int col = 0; col < width; col++) {
          int new_value = cell_value(rule, neighbor_population_of(state, col, row));
          if(new_value == -1) {
            continue;
          }
          rb_ary_store(row_array, col, INT2FIX(new_value));
      }
  }
  return next_state;
}

VALUE method_dup_state(VALUE self, VALUE state) {
    int height = (int)RARRAY_LEN(state);
    VALUE dup =  rb_ary_new2(height);
    for(int y = 0; y < height; y++) {
        VALUE row = rb_ary_dup(rb_ary_entry(state, y));
        rb_ary_push(dup, row);
    }
    return dup;
}
