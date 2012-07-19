indexing
	description: "Basic event manager";
	date: "$Date$";
	revision: "$Revision$";
	author: "Paul G. Crismer, Eric Fafchamps";

deferred class
 
	CURSES_EVENT_MANAGER

feature -- Status

	event_available : BOOLEAN is
		-- is there an available event ?
	deferred
	end

	exit_condition : BOOLEAN is
		-- has the exit condition been met ?
	deferred
	end

feature -- Operations

	initialize is
		-- initialize event loop
	deferred
	end

	get_event is
		-- get an event
	deferred
	end

	on_event is
		-- process event
	require
		event_available: event_available
	deferred
	end

	on_idle is
		-- idle processing (no event)
	require
		no_event_available: not event_available
	deferred
	end

	terminate is
		-- terminate event loop
	deferred
	end

    do_events is
		-- handle event loop
	do
		from
			initialize
			get_event
		until
			exit_condition = True
		loop
			if event_available then
				on_event
			else
				on_idle
			end
			get_event
		end
		terminate
	end

end -- class CURSES_EVENT_MANAGER
-----------------------------------------------------------
-- Copyright (C) 1999-2009 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 2
-- (see forum.txt)
-----------------------------------------------------------


