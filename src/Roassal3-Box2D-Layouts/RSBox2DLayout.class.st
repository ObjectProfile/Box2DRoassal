"
I am a RSLayout that uses Box2DLite project to distribute shapes and edges in the canvas.
"
Class {
	#name : #RSBox2DLayout,
	#superclass : #RSEdgeDrivenLayout,
	#instVars : [
		'world',
		'nodes'
	],
	#category : #'Roassal3-Box2D-Layouts'
}

{ #category : #accessing }
RSBox2DLayout >> box2dBodyKey [
	^ #box2dBodyKey
]

{ #category : #hook }
RSBox2DLayout >> doExecute: aCollection [

	nodes := aCollection.
	self start.
	20 timesRepeat: [ self step ]
]

{ #category : #accessing }
RSBox2DLayout >> jointAnchorFor: aRSLine [

	^ 10@0
]

{ #category : #accessing }
RSBox2DLayout >> massFor: aRSShape [
	^ 150.0
]

{ #category : #accessing }
RSBox2DLayout >> nodes [
	^ nodes
]

{ #category : #accessing }
RSBox2DLayout >> nodes: aCollection [ 
	nodes := aCollection
]

{ #category : #hook }
RSBox2DLayout >> start [

	world := B2World new.
	world setGravity: 0.0 @ 0.0 iterations: 10.

	nodes do: [ :each |
		|newBody |
		newBody := B2Body extent: each extent mass: (self massFor: each).
		newBody position: each position.
		each propertyAt: self box2dBodyKey put: newBody.
		world addBody: newBody ].

	edges do: [ :each |
		| newJoint body1 body2 |
		body1 := each from propertyAt: self box2dBodyKey.
		body2 := each to propertyAt: self box2dBodyKey.
		newJoint := B2Joint body1: body1 body2: body2 anchor: (self jointAnchorFor: each).
		newJoint softness: 0.25; biasFactor: 0.5.
		world addJoint: newJoint ].

]

{ #category : #hook }
RSBox2DLayout >> step [

	world step: 1.0 / 60.0.

	nodes do: [ :each |
		| body |
		body := each propertyAt: self box2dBodyKey.
		body updateRSShape: each ].

	
]

{ #category : #accessing }
RSBox2DLayout >> world [
	^ world
]
