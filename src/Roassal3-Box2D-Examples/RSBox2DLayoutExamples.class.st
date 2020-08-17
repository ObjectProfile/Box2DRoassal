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
		color: Color blue;
		connectFrom: [ :v | v // 2 ].
	
	layout := RSBox2DLayout new.
	layout
		nodes: c nodes;
		edges: edges;
		start.
	
	c newAnimation repeat onStepDo: [ :t |
		layout step.
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
"	builder layout grid."
	builder build.
	builder canvas edges copy do: #remove.

	edges := RSEdgeBuilder line
		canvas: c;
		color: (Color blue alpha: 0.2);
		connectFrom: #superclass.

	self flag: #todo. "Why is this necessary?"
	c nodes do: [ :each | each position: 0 asPoint  ].

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
