#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

/* FIXME:
 Check these declarations against the C/Fortran source code.
*/

/* .Call calls */
extern SEXP Aspect(SEXP, SEXP, SEXP);
extern SEXP ccl(SEXP);
extern SEXP Dest(SEXP, SEXP, SEXP, SEXP);
extern SEXP Dist(SEXP, SEXP, SEXP, SEXP);
extern SEXP geographicPS(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP getmin(SEXP, SEXP);
extern SEXP movewindow(SEXP, SEXP, SEXP, SEXP);
extern SEXP pip(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP projectedPS(SEXP, SEXP);
extern SEXP Slope(SEXP, SEXP, SEXP);
extern SEXP writeascdata(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);

static const R_CallMethodDef CallEntries[] = {
  {"Aspect",       (DL_FUNC) &Aspect,       3},
  {"ccl",          (DL_FUNC) &ccl,          1},
  {"Dest",         (DL_FUNC) &Dest,         4},
  {"Dist",         (DL_FUNC) &Dist,         4},
  {"geographicPS", (DL_FUNC) &geographicPS, 6},
  {"getmin",       (DL_FUNC) &getmin,       2},
  {"movewindow",   (DL_FUNC) &movewindow,   4},
  {"pip",          (DL_FUNC) &pip,          6},
  {"projectedPS",  (DL_FUNC) &projectedPS,  2},
  {"Slope",        (DL_FUNC) &Slope,        3},
  {"writeascdata", (DL_FUNC) &writeascdata, 8},
  {NULL, NULL, 0}
};

void R_init_SDMTools(DllInfo *dll)
{
  R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
}
