#!/bin/sh

#add urcu mb

for a in test_urcu test_urcu_mb test_qsbr test_rwlock test_perthreadlock; do
	echo Executing $a
	./${a} $* |grep "total num"
done