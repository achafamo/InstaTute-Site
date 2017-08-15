// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function () {
	
	  var date = new Date();
		var d = date.getDate();
		var m = date.getMonth();
		var y = date.getFullYear();
		
		/*  className colors
		
		className: default(transparent), important(red), chill(pink), success(green), info(blue)
		
		*/		
		
		  
		/* initialize the external events
		-----------------------------------------------------------------*/
	
		$('#external-events div.external-event').each(function() {
		
			// create an Event Object (http://arshaw.com/fullcalendar/docs/event_data/Event_Object/)
			// it doesn't need to have a start or end
			var eventObject = {
				title: $.trim($(this).text()) // use the element's text as the event title
			};
			
			// store the Event Object in the DOM element so we can get to it later
			$(this).data('eventObject', eventObject);
			
			// make the event draggable using jQuery UI
			$(this).draggable({
				zIndex: 999,
				revert: true,      // will cause the event to go back to its
				revertDuration: 0  //  original position after the drag
			});
			
		});
	
	
			/* initialize the calendar
			-----------------------------------------------------------------*/
		var friends_calendar = $('#calendars').fullCalendar({
		  
			header: {
					left: 'title',
					center: 'agendaDay,agendaWeek,month',
					right: 'prev,next today'
				},
			defaultView: 'agendaWeek',
		  editable: true,
			firstDay: 1, //  1(Monday) this can be changed to 0(Sunday) for the USA system
			selectable: true,
			
	
		
			selectHelper: true,
			select: function(start, end, allDay) {
				var title = prompt('Event Title:');
				if (title) {
					calendar.fullCalendar('renderEvent',
						{
							title: title,
							start: start,
							end: end,
							allDay: allDay
						},
						true // make the event "stick"
					);
				}
				calendar.fullCalendar('unselect');
			},
			droppable: true, // this allows things to be dropped onto the calendar !!!
			drop: function(date, allDay) { // this function is called when something is dropped
	
				// retrieve the dropped element's stored Event Object
				var originalEventObject = $(this).data('eventObject');
		
				// we need to copy it, so that multiple events don't have a reference to the same object
				var copiedEventObject = $.extend({}, originalEventObject);
		
				// assign it the date that was reported
				copiedEventObject.start = date;
				copiedEventObject.allDay = allDay;
		
				// render the event on the calendar
				// the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
				$('#calendars').fullCalendar('renderEvent', copiedEventObject, true);
		
				// is the "remove after drop" checkbox checked?
				if ($('#drop-remove').is(':checked')) {
					// if so, remove the element from the "Draggable Events" list
					$(this).remove();
				}
		
			},
			events: {
				url: '/events/calendar',
				type: 'GET',
				error: function () {
				  alert('There was an error while fetching events.');
				}
			},
				eventClick:  function(event, jsEvent, view) {
        //set the values and open the modal
				console.log(event.title);
				$("#startTime").html(moment(event.start).format('MMM Do h:mm A'));
        $("#endTime").html(moment(event.end).format('MMM Do h:mm A'));
        $("#eventInfo").html(event.description);
        $("#eventLink").attr('href', event.url);
				$(".eventTitle").html(event.title);
				$(".eventDescription").html(event.description);				
				$(".eventContent").css('display', 'block');
        $(".eventContent").css('left', '25%');
        $(".eventContent").css('top', '30%');
		
        return false;
      },

			eventColor: '#ff3b30'

			});
			$(".eventContent").click(function() {
		          $(".eventContent").css('display', 'none');
		  });
	});
