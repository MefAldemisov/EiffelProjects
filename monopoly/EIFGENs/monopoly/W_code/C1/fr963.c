/*
 * Code for class FREE_PARCING_SQUARES
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"


#ifdef __cplusplus
extern "C" {
#endif

extern void F963_7236(EIF_REFERENCE);
extern void EIF_Minit963(void);

#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {FREE_PARCING_SQUARES}.describe */
void F963_7236 (EIF_REFERENCE Current)
{
	GTCX
	char *l_feature_name = "describe";
	RTEX;
	EIF_TYPED_VALUE ur1x = {{0}, SK_REF};
#define ur1 ur1x.it_r
	EIF_REFERENCE tr1 = NULL;
	RTSN;
	RTDA;
	RTLD;
	
	RTLI(3);
	RTLR(0,tr1);
	RTLR(1,ur1);
	RTLR(2,Current);
	RTLIU(3);
	RTLU (SK_VOID, NULL);
	RTLU (SK_REF, &Current);
	
	RTEAA(l_feature_name, 962, Current, 0, 0, 13414);
	RTSA(Dtype(Current));
	RTSC;
	RTME(Dtype(Current), 0);
	RTGC;
	RTDBGEAA(962, Current, 13414);
	RTIV(Current, RTAL);
	RTHOOK(1);
	tr1 = RTMS_EX_H("\012Free parcing: nothing happends",31,339327603);
	ur1 = tr1;
	(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_TYPED_VALUE)) RTWF(30, Dtype(Current)))(Current, ur1x);
	RTVI(Current, RTAL);
	RTRS;
	RTHOOK(2);
	RTDBGLE;
	RTMD(0);
	RTLE;
	RTLO(2);
	RTEE;
#undef ur1
}

void EIF_Minit963 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
