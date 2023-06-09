<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
<style>
.btn_group {
	margin-top: 40;
	margin-left: -15;
	margin-right: -15;
	margin-bottom: 20;
	display: -webkit-box;
	display: -moz-box;
	display: -ms-flexbox;
	display: -moz-flex;
	display: -webkit-flex;
	display: flex;
	justify-content: space-between;
	list-style: none;
}
</style>
</head>
<body>
	<div class="btn_group">
		<button type="button" onclick="location.href='sale'"
			style="height: 70px; width: 200px; font-size: 20;">판매</button>
		<button type="button" onclick="location.href='stock'"
			style="height: 70px; width: 200px; font-size: 20;">재고</button>
		<button type="button" onclick="location.href='statistic'"
			style="height: 70px; width: 200px; font-size: 20;">통계</button>
		<button type="button" onclick="location.href='myPage'"
			style="height: 70px; width: 200px; font-size: 20;">내 정보</button>
	</div>
</body>
</html>