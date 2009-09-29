/*
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *
 * Copyright (c) 2009 Mathieu Desnoyers
 */

byte lock = 0;
byte refcount = 0;

inline spin_lock(lock)
{
	do
	:: 1 ->	atomic {
			if
			:: (lock) ->
				skip;
			:: else ->
				lock = 1;
				break;
			fi;
		}
	od;
}

inline spin_unlock(lock)
{
	lock = 0;
}

proctype proc_X()
{
	do
	:: 1 ->
		spin_lock(lock);
		refcount = refcount + 1;
		refcount = refcount - 1;
		spin_unlock(lock);
	od;
}

init
{
	run proc_X();
	run proc_X();
}