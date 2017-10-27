<%--

    Copyright 2013 Netflix, Inc.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

--%>

<%@ page import="com.netflix.ice.reader.ReaderConfig" %>

<!DOCTYPE html>
<html ng-app="ice">
<head>
  <title><g:layoutTitle default="${ReaderConfig.getInstance().companyName} AWS Usage Dashboard"/></title>
  <meta http-equiv="X-UA-Compatible" content="chrome=1">
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <link rel="stylesheet" href="${resource(dir: 'css/ui-lightness', file: 'jquery-ui-1.10.3.custom.min.css')}"/>
  <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}"/>
  <link rel="stylesheet" href="${resource(dir: 'css', file: 'houzz.css')}"/>
  <g:layoutHead/>
</head>
<body class="nactest" ng-controller="mainCtrl">
  <div class="titlebar" ng-show="!graphOnly()">
    <div class="header" style="padding-top:15px; height:43px">
      <a href="${resource(dir: '/')}">
        <span class="mainHeader">
          ${ReaderConfig.getInstance().companyName} AWS Usage Dashboard
        </span>
      </a>
    </div>
  </div>
  <ul class="nav" ng-show="!graphOnly()">
    <li class="menuButton">
        <a class="" href="${resource(dir: 'dashboard', file: 'summary')}" ng-click="reload()">AWS Summary</a>
    </li>
    <li class="menuButton dropdown">
      <a class="link_with_params" href="${resource(dir: 'dashboard', file: 'detail')}#{{getTimeParams()}}" ng-click="reload()">AWS Details</a>
      <ul>
        <li class="menuButton"><a class="link_with_params" href="${resource(dir: 'dashboard', file: 'detail')}#groupBy=Product&{{getTimeParams()}}" ng-click="reload()">General Details</a></li>
        <g:if test="${ReaderConfig.getInstance().resourceService != null}">
        <li class="menuButton"><a class="link_with_params" href="${resource(dir: 'dashboard', file: 'detail')}#showResourceGroups=true&groupBy=Product&{{getTimeParams()}}" ng-click="reload()">Details With Resource Groups</a></li>
        </g:if>
      </ul>
    </li>
    <li class="menuButton dropdown">
      <a class="link_with_params" href="${resource(dir: 'dashboard', file: 'reservation')}#{{getTimeParams()}}" ng-click="reload()">Reservations</a>
      <ul>
        <li class="menuButton"><a class="link_with_params" href="/ice/dashboard/reservation#groupBy=UsageType&consolidate=daily&product=ec2_instance&operation=ReservedInstancesHeavy&{{getTimeParams()}}" ng-click="reload()">Reservations By Instance Type</a></li>

        <li class="menuButton"><a class="link_with_params" href="/ice/dashboard/reservation#groupBy=Operation&showZones=true&consolidate=daily&product=ec2_instance&{{getTimeParams()}}" ng-click="reload()">Ondemand vs Reservations Cost</a></li>

        <li class="menuButton"><a class="link_with_params" href="${resource(dir: 'dashboard', file: 'reservation')}#{{getTimeParams()}}" ng-click="reload()">Reservations By Region</a></li>

        <li class="menuButton"><a class="link_with_params" href="${resource(dir: 'dashboard', file: 'reservation')}#showZones=true&{{getTimeParams()}}" ng-click="reload()">Reservations By Zone</a></li>

       
      </ul>
    </li>
    <g:if test="${ReaderConfig.getInstance().resourceService != null}">
    <li class="menuButton dropdown">
      <a class="link_with_params" href="${resource(dir: 'dashboard', file: 'breakdown')}#groupBy=ApplicationGroup&{{getTimeParams()}}" ng-click="reload()">Breakdown</a>
      <ul>
        <li class="menuButton"><a class="" href="${resource(dir: 'dashboard', file: 'breakdown')}#groupBy=ApplicationGroup&{{getTimeParams()}}" ng-click="reload()">By Team</a></li>
        <li class="menuButton"><a class="" href="${resource(dir: 'dashboard', file: 'breakdown')}#{{getTimeParams()}}" ng-click="reload()">By Resource Group</a></li>
        <li class="menuButton"><a class="" href="${resource(dir: 'dashboard', file: 'editappgroup')}" ng-click="reload()">Create New Application Group</a></li>

      </ul>
    </li>
    </g:if>

    <li class="menuButton dropdown">
      <a class="link_with_params houzz_header" href="${resource(dir: 'dashboard', file: 'reservation')}#{{getTimeParams()}}" ng-click="reload()">EC2</a>
      <ul>

        <li class="menuButton"><a class="link_with_params" href="/ice/dashboard/detail#groupBy=Operation&consolidate=hourly&product=ec2,ec2_instance&{{getTimeParams()}}" ng-click="reload()">Total Cost / Type</a></li>

        <li class="menuButton"><a class="link_with_params" href="/ice/dashboard/breakdown#groupBy=ApplicationGroup&{{getTimeParams()}}" ng-click="reload()">Weekly Instance Cost by Team</a></li>

        <li class="menuButton"><a class="link_with_params" href="/ice/dashboard/detail#groupBy=UsageType&consolidate=daily&product=ec2_instance&operation=OndemandInstances&{{getTimeParams()}}" ng-click="reload()">Ondemand Instance Cost / Instance Type</a></li>

        <li class="menuButton"><a class="link_with_params" href="/ice/dashboard/detail#groupBy=UsageType&consolidate=daily&product=ec2_instance&operation=OndemandInstances&account=688976015282&{{getTimeParams()}}" ng-click="reload()">- Production</a></li>

        <li class="menuButton"><a class="link_with_params" href="/ice/dashboard/detail#groupBy=UsageType&consolidate=daily&product=ec2_instance&operation=OndemandInstances&account=056264667071&{{getTimeParams()}}" ng-click="reload()">- Datawarehouse</a></li>

        <li class="menuButton"><a class="link_with_params" href="/ice/dashboard/detail#groupBy=UsageType&consolidate=daily&product=ec2_instance&operation=OndemandInstances&account=477121734600&{{getTimeParams()}}" ng-click="reload()">- Staging</a></li>

        <li class="menuButton"><a class="link_with_params" href="/ice/dashboard/detail#groupBy=UsageType&consolidate=daily&product=ec2_instance&operation=OndemandInstances&account=007195287850&{{getTimeParams()}}" ng-click="reload()">- Development</a></li>

        <li class="menuButton"><a class="link_with_params" href="/ice/dashboard/detail#groupBy=Account&consolidate=daily&product=ec2_instance&operation=OndemandInstances&{{getTimeParams()}}" ng-click="reload()">Ondemand Instance Cost / Account</a></li>

        <li class="menuButton"><a class="link_with_params" href="/ice/dashboard/detail#showResourceGroups=true&groupBy=UsageType&resourceGroup=ec2_instance&{{getTimeParams()}}" ng-click="reload()">Unmapped Instances (No Team)</a></li>

        <li class="menuButton"><a class="link_with_params" href="/ice/dashboard/detail#showResourceGroups=true&groupBy=Account&resourceGroup=ec2_instance&{{getTimeParams()}}" ng-click="reload()">Unmapped Cost (No Team) / Account</a></li>


      </ul>
    </li>

    <li class="menuButton dropdown">
      <a class="link_with_params houzz_header" href="${resource(dir: 'dashboard', file: 'reservation')}#{{getTimeParams()}}" ng-click="reload()">EBS</a>
      <ul>

        <li class="menuButton"><a class="link_with_params" href="/ice/dashboard/detail#usage_cost=cost&groupBy=UsageType&consolidate=daily&product=ebs&{{getTimeParams()}}" ng-click="reload()">By Volume Type</a></li>

        <li class="menuButton"><a class="link_with_params" href="/ice/dashboard/detail#usage_cost=cost&groupBy=Account&consolidate=daily&product=ebs&&usageType=EBS:VolumeUsage.gp2&{{getTimeParams()}}" ng-click="reload()">- GP2 / Account</a></li>

        <li class="menuButton"><a class="link_with_params" href="/ice/dashboard/detail#usage_cost=cost&groupBy=Account&consolidate=daily&product=ebs&usageType=EBS:VolumeUsage.st1&{{getTimeParams()}}" ng-click="reload()">- ST1 / Account</a></li>

      </ul>
    </li>


    <li class="menuButton dropdown">
      <a class="link_with_params houzz_header" href="${resource(dir: 'dashboard', file: 'reservation')}#{{getTimeParams()}}" ng-click="reload()">S3</a>
      <ul>
        <li class="menuButton"><a class="link_with_params" href="/ice/dashboard/detail#usage_cost=cost&groupBy=UsageType&consolidate=daily&product=s3&{{getTimeParams()}}" ng-click="reload()">By Storage Type</a></li>

        <li class="menuButton"><a class="link_with_params" href="/ice/dashboard/detail#groupBy=Account&consolidate=daily&plotType=area&product=s3&operation=StandardStorage&{{getTimeParams()}}" ng-click="reload()">By Account</a></li>
      </ul>
    </li>
  </ul>
  <div class="clear"></div>
  <g:layoutBody/>
  <form action="download" id="download_form" method="post" style="display: none;">
  </form>
</body>
<script type="text/javascript">
  var throughput_metricname = '${ReaderConfig.getInstance().throughputMetricService == null ? "" : ReaderConfig.getInstance().throughputMetricService.getMetricName()}';
  var throughput_metricunitname = '${ReaderConfig.getInstance().throughputMetricService == null ? "" : ReaderConfig.getInstance().throughputMetricService.getMetricUnitName()}';
  var throughput_factoredCostCurrencySign = '${ReaderConfig.getInstance().throughputMetricService == null ? "" : ReaderConfig.getInstance().throughputMetricService.getFactoredCostCurrencySign()}';
  var throughput_factoredCostMultiply = '${ReaderConfig.getInstance().throughputMetricService == null ? "" : ReaderConfig.getInstance().throughputMetricService.getFactoredCostMultiply()}';
  var global_currencySign = '${ReaderConfig.getInstance().currencySign}';
</script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.9.1.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.10.1.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-timepicker-addon.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'angular-1.0.5.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'angular-ui.js')}"></script>
<script type="text/javascript" src="${ReaderConfig.getInstance().highstockUrl}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'ice.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'houzz.js')}"></script>
</html>
