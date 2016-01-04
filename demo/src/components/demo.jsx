'use strict';

var Describe = window.Describe;

var Demo = React.createClass({
	render: function () {
		function createList(text, its) {
			return <Describe text={text} its={its} key={text} />;
		}

		var items = Object.keys(this.props.describes).map(function (describe) {
			return createList(describe, this.props.describes[describe]);
		}, this);

		return <ul>{items}</ul>;
	}
});

window.jinterDemo = window.jinterDemo || {};
window.jinterDemo.Demo = Demo;