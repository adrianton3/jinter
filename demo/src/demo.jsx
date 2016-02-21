'use strict';

var Demo = window.jinterDemo.Demo;

React.render(
	<Demo describes={window.snippets} />,
	document.getElementById('container')
);