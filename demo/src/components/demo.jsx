'use strict';

var Describe = window.Describe;

var Demo = React.createClass({
	render: function () {
		function createList(text, its, index) {
			return <Describe text={text} its={its} key={index} />;
		}

		var items = Object.keys(this.props.describes).map(function (describe, index) {
			return createList(describe, this.props.describes[describe], index);
		}, this);

		return <ul>{items}</ul>;
	}
});

window.jinterDemo = window.jinterDemo || {};
window.jinterDemo.Demo = Demo;