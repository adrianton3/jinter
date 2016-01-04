'use strict';

var It = React.createClass({
	getInitialState: function () {
		return {};
	},
	evJs: function (source) {
		var resultRaw = new Function('source', 'return eval(source)')(source);

		if (resultRaw === null) {
			return 'null';
		} else if (resultRaw === undefined) {
			return 'undefined';
		} else {
			return resultRaw.toString();
		}
	},
	evJinter: function (source) {
		var tree = esprima.parse(source);
		jinter.processLiterals(tree);
		jinter.processVars(tree);

		var resultRaw = jinter.ev(tree, jinter.EMPTY);

		if (resultRaw) {
			return resultRaw.asString();
		} else {
			return 'undefined';
		}
	},
	ev: function (e) {
		e.preventDefault();

		this.setState({
			resultJinter: this.evJinter(this.props.source),
			resultJs: this.evJs(this.props.source)
		});
	},
	rawHljs: function (source) {
		var highlight = hljs.highlight('javascript', source, false);
		return { __html: highlight.value };
	},
	render: function () {
		var message = this.state.hasOwnProperty('resultJinter') ?
			"jinter: " + this.state.resultJinter + "; js: " + this.state.resultJs :
			"click to eval";

		return <li onClick={this.ev}>
			<div className="it text">{this.props.text}</div>
			<pre
				className="hljs source"
				dangerouslySetInnerHTML={this.rawHljs(this.props.source)}
			/>
			<pre
				className="hljs source result"
			>{message}</pre>
		</li>;
	}
});

window.jinterDemo = window.jinterDemo || {};
window.jinterDemo.It = It;