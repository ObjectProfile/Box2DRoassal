"
I have usage examples of RSBox2DLayout.
"
Class {
	#name : #RSBox2DLayoutExamples,
	#superclass : #RSAbstractExamples,
	#category : #'Roassal3-Box2D-Examples'
}

{ #category : #examples }
RSBox2DLayoutExamples >> example1 [
	<script: 'self new example1 open'>
	| c |
	c := RSCanvas new.
	
	c addAll: ((1 to: 200) collect: [:i |
		RSLabel new
			model: i;
			text: i asString;
			bold;
			color: Color random;
			yourself ]).
		
	RSEdgeBuilder arrowedLine
		canvas: c;
		color: Color gray translucent;
		connectFrom: [ :v | v // 2 ].
	
	RSBox2DLayout on: c nodes.

	c nodes @ RSDraggable.
	c nodes @ RSHighlightable defaultRed.
	c addInteraction: RSCanvasController.
	^ c
]

{ #category : #examples }
RSBox2DLayoutExamples >> example2 [ 
	<script: 'self new example2 open'>
	| c edges layout |
	c := RSCanvas new.
	c addAll: ((1 to: 50) collect: [:i |
		RSLabel new
			model: i;
			text: 'Number ', i asString;
			color: Color random;
			yourself ]).

	edges := RSEdgeBuilder line
		canvas: c;
		color: Color blue translucent;
		connectFrom: [ :v | v // 2 ].
	
	layout := RSBox2DLayout new.
	layout
		nodes: c nodes;
		edges: edges;
		start.
	
"	c newAnimation repeat onStepDo: [ :t |
		layout step.
		c zoomToFit ].
"

	c newAnimation 
		duration: 4 seconds;
		from: layout deltaTime;
		to: Float epsilon;
		easing: RSEasing expIn;
		onStepDo: [ :t |
			layout deltaTime: t; step.
			c zoomToFit ].


	c nodes @ RSHighlightable defaultRed.
	
		^ c
]

{ #category : #examples }
RSBox2DLayoutExamples >> example3 [
	<script: 'self new example3 open'>
	| c edges layout builder |
	c := RSCanvas new.


	builder := RSUMLClassBuilder new.
	builder container: c.
	builder classes: RSEvent withAllSubclasses.
	builder layout grid gapSize: -1.
	builder build.
	builder canvas edges copy do: #remove.

	edges := RSEdgeBuilder line
		canvas: c;
		color: (Color blue alpha: 0.2);
		connectFrom: #superclass.



	layout := RSBox2DLayout new.
	layout
		nodes: c nodes;
		edges: edges;
		start.

	c shapes do: [ :each | 
		each when: RSMouseClick send: #inspect to: (each propertyAt: #box2dBodyKey) ].
	
	c newAnimation repeat onStepDo: [ :t |
		layout step.
		c zoomToFit ].

	^ c
]

{ #category : #examples }
RSBox2DLayoutExamples >> example4 [
	<script: 'self new example4 open'>
	| c edges layout maxMethodSize sizeScale colorPalette highlight |
	c := RSCanvas new.
	
	maxMethodSize := Collection withAllSubclasses max: [ :each | each methods size ].
	sizeScale := NSScale linear domain: { 0. maxMethodSize }; range: { 1.0. 15 }; yourself.
	colorPalette := RSColorPalette qualitative dark28.
	highlight := RSHighlightable defaultRed.
	
	c addAll: (Collection withAllSubclasses collect: [:aClass |
		|label|
		label := RSLabel new
			text: aClass name;
			color: (colorPalette scale: aClass category);
			yourself.
		label scaleBy: (sizeScale scale: aClass methods size).
		({ label } asGroup asShapeFor: aClass)
			padding: 10;
			addInteraction: highlight;
			when: RSMouseClick send: #browse to: aClass;
			yourself ]).

	edges := RSEdgeBuilder line
		canvas: c;
		color: Color transparent;
		connectFrom: #superclass.
	
	layout := RSBox2DLayout new.
	layout
		nodes: c nodes;
		edges: edges;
		start.
	
	c newAnimation repeat onStepDo: [ :t |
		layout step.
		c zoomToFit ].

	^ c
]

{ #category : #examples }
RSBox2DLayoutExamples >> example4b [
	<script: 'self new example4b open'>
	| c edges layout maxMethodSize sizeScale colorPalette highlight |
	c := RSCanvas new.
	
	maxMethodSize := Collection withAllSubclasses max: [ :each | each methods size ].
	sizeScale := NSScale linear domain: { 0. maxMethodSize }; range: { 1.0. 15 }; yourself.
	colorPalette := RSColorPalette qualitative dark28.
	highlight := RSHighlightable defaultRed.
	
	c addAll: (Collection withAllSubclasses collect: [:aClass |
		|label|
		label := RSLabel new
			text: aClass name;
			color: (colorPalette scale: aClass category);
			yourself.
		label scaleBy: (sizeScale scale: aClass methods size).
		({ label } asGroup asShapeFor: aClass)
			padding: 10;
			addInteraction: highlight;
			when: RSMouseClick send: #browse to: aClass;
			yourself ]).

	edges := RSEdgeBuilder line
		canvas: c;
		color: Color transparent;
		connectFrom: #superclass.
	
	layout := RSBox2DLayout new.
	layout
		nodes: c nodes;
		edges: edges;
		start.
	
	c newAnimation 
		duration: 4 seconds;
		from: layout deltaTime;
		to: Float epsilon;
		easing: RSEasing expIn;
		onStepDo: [ :t |
			layout deltaTime: t; step.
			c zoomToFit ].

	^ c
]

{ #category : #examples }
RSBox2DLayoutExamples >> example4c [
	<script: 'self new example4c open'>

	| c edges layout maxMethodSize sizeScale colorPalette highlight |
	c := RSCanvas new.
	layout := RSBox2DLayout new.
	
	maxMethodSize := Collection withAllSubclasses max: [ :each | each methods size ].
	sizeScale := NSScale linear domain: { 0. maxMethodSize }; range: { 1.0. 15 }; yourself.
	colorPalette := RSColorPalette qualitative dark28.
	highlight := RSHighlightable defaultRed.
	
	c addAll: (Collection withAllSubclasses collect: [:aClass |
		|label|
		label := RSLabel new
			text: aClass name;
			color: (colorPalette scale: aClass category);
			yourself.
		label scaleBy: (sizeScale scale: aClass methods size).
		({ label } asGroup asShapeFor: aClass)
			padding: 10;
			addInteraction: highlight;
			draggable;
			when: RSMouseDragStart do: [ :event | layout fix: event shape ];
			when: RSMouseDragEnd do: [ :event | layout unfix: event shape ];
			when: RSMouseDragging do: [ :event |
				(event shape propertyAt: #box2dBodyKey) position: event position ];
			when: RSMouseClick send: #browse to: aClass;
			yourself ]).

	edges := RSEdgeBuilder line
		canvas: c;
		color: Color transparent;
		connectFrom: #superclass.
	
	layout
		nodes: c nodes;
		edges: edges;
		start.
	
	c newAnimation repeat onStepDo: [ :t | layout step].

	c addInteraction: RSCanvasController.

	^ c
]

{ #category : #examples }
RSBox2DLayoutExamples >> example5 [
	<script: 'self new example5 open'>
	| c layout |
	c := RSCanvas new.
	
	c add: (
		RSLabel new
			model: 1;
			text: 1 asString;
			position: 1@1;
			color: Color orange;
			yourself).

	c add: (
		RSLabel new
			model: 2;
			text: 2 asString;
			position: 5 asPoint;
			color: Color blue;
			yourself).

	c nodes do: [ :each | each when: RSMouseClick send: #inspect to: each ].
		
	layout := RSBox2DLayout new.
	layout
		nodes: c nodes;
		edges: #();
		start.
	
	c newAnimation repeat onStepDo: [ :t |
		layout step.
		c zoomToFit ].

	c addInteraction: RSCanvasController.
	c nodes @ RSDraggable.
	c nodes @ RSHighlightable defaultRed.

	^c

]
