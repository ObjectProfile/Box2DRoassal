Class {
	#name : #BaselineOfBox2DRoassal,
	#superclass : #BaselineOf,
	#category : #BaselineOfBox2DRoassal
}

{ #category : #baseline }
BaselineOfBox2DRoassal >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		self
			declareBox2DLiteOn: spec;
			declareRoassal3On: spec.

		spec
			package: 'Roassal3-Box2D-Examples'
			with: [ spec requires: #( 'Roassal3' 'Roassal3-Box2D-Layouts' ) ];
			package: 'Roassal3-Box2D-Layouts'
			with: [ spec requires: #( 'Box2DLite' 'Roassal3' ) ] ]
]

{ #category : #'external projects' }
BaselineOfBox2DRoassal >> declareBox2DLiteOn: spec [

	spec
		baseline: 'Box2DLite'
		with: [ 
			spec repository: 'github://tinchodias/Box2DLiteForPharo/src' ]
]

{ #category : #'external projects' }
BaselineOfBox2DRoassal >> declareRoassal3On: spec [

	spec
		baseline: 'Roassal3'
		with: [ 
			spec repository: 'github://ObjectProfile/Roassal3:master/src' ]
]
