import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:viria_dashboard/utils/app_images.dart';
import '../../custom_widgets/custom_header.dart';
import '../../custom_widgets/legend_dot.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../sidemenu/sidemenu.dart';
import 'controller/dashboard_controller.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  Widget revenueContainer(String icon,Color contColor,String revenue, String title, String percent, Color circleColor){
    return Container(
      height: 220.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: contColor
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 38.h,horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: circleColor,
              radius: 20,
              child: Center(child: SvgPicture.asset(icon,height: 18,width: 18,color: kWhiteColor,)),
            ),
            Text(
              revenue,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.bold,fontSize: 18.sp,color: kDarkBlueColor),
            ),
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w500,fontSize: 12.sp,color: kGreyColor6),
            ),
            Text(
              "$percent% from last week",
              overflow: TextOverflow.ellipsis,
              style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w500,fontSize: 9.sp,color: kBlueColor1),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SideMenu(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customHeader("Dashboard"),
                    Container(
                      color: kWhiteShade2Color,
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height - 120,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 32.h,
                          bottom: 32.h,
                          left: 32.w,
                          right: 44.w,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              spacing: 31.w,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    height: 348.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: kWhiteColor,
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 4),
                                          blurRadius: 20,
                                          spreadRadius: 0,
                                          color: kWhiteShade6Color,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(24),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Total Revenue",
                                            overflow: TextOverflow.ellipsis,
                                            style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w600,fontSize: 16.sp,color: kDarkBlueColor1),
                                          ),
                                          Row(
                                            spacing: 12.w,
                                            children: [
                                              Expanded(child: revenueContainer(kDollarIcon,kRedLightColor, "\$12.5k", "Total Revenue", "+12", kPinkColor)),
                                              Expanded(child: revenueContainer(kUserAddIcon,kYellowLightColor, "1,230", "Active Users", "+8", kPeachColor)),
                                              Expanded(child: revenueContainer(kCrownIcon,kGreenLightColor, "845", "Active Subscriptions", "-3", kGreenColor4)),
                                              Expanded(child: revenueContainer(kVideosIcon,kPurpleLightColor, "3,420", "Videos Generated", "+15", kLightPurpleColor)),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 348.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: kWhiteColor,
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 4),
                                          blurRadius: 20,
                                          spreadRadius: 0,
                                          color: kWhiteShade6Color,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(24),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "User Growth & Engagement",
                                            overflow: TextOverflow.ellipsis,
                                            style: AppStyles.blackTextStyle().copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18.sp,
                                              color: kDarkBlueColor1,
                                            ),
                                          ),
                                          SizedBox(height: 32.h),
                                          Expanded(
                                            child: Obx(() => LineChart(
                                              LineChartData(
                                                titlesData: FlTitlesData(
                                                  bottomTitles: AxisTitles(
                                                    sideTitles: SideTitles(
                                                      showTitles: true,
                                                      interval: 1,
                                                      reservedSize: 32,
                                                      getTitlesWidget: (value, _) {
                                                        const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec'];
                                                        return Text(months[value.toInt()], style: AppStyles.nunitoTextStyle().copyWith(fontSize: 10.sp,fontWeight: FontWeight.w400,color: kGreyColor7));
                                                      },
                                                    ),
                                                  ),
                                                  leftTitles: AxisTitles(
                                                    sideTitles: SideTitles(
                                                      showTitles: true,
                                                      interval: 100,
                                                      reservedSize: 40,
                                                      getTitlesWidget: (value, _) => Text(value.toInt().toString(),style: AppStyles.blackTextStyle().copyWith(fontSize: 12.sp,color: kGreyColor8,fontWeight: FontWeight.w400),),
                                                    ),
                                                  ),
                                                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                                ),

                                                gridData: FlGridData(show: true, drawVerticalLine: false),
                                                borderData: FlBorderData(show: false),

                                                lineBarsData: [
                                                  LineChartBarData(
                                                    isCurved: true,
                                                    color: Colors.purple,
                                                    dotData: FlDotData(show: false),
                                                    spots: controller.newSignups,
                                                  ),
                                                  LineChartBarData(
                                                    isCurved: true,
                                                    color: Colors.red,
                                                    dotData: FlDotData(show: false),
                                                    spots: controller.videosGenerated,
                                                  ),
                                                  LineChartBarData(
                                                    isCurved: true,
                                                    color: Colors.green,
                                                    dotData: FlDotData(show: false),
                                                    spots: controller.activeSubscribers,
                                                  ),
                                                ],

                                                lineTouchData: LineTouchData(
                                                  enabled: true,
                                                  handleBuiltInTouches: true,
                                                  touchTooltipData: LineTouchTooltipData(
                                                    getTooltipColor: (touchedSpot) => Colors.transparent,
                                                    tooltipRoundedRadius: 0,
                                                    tooltipPadding: EdgeInsets.zero,
                                                    tooltipMargin: 0,
                                                    fitInsideHorizontally: true,
                                                    fitInsideVertically: true,
                                                    getTooltipItems: (touchedSpots) => touchedSpots.map((e) => null).toList(),
                                                  ),
                                                  touchCallback: (event, response) {
                                                    if (!event.isInterestedForInteractions || response == null || response.lineBarSpots == null) return;
                                                    final touchedSpot = response.lineBarSpots!.first;
                                                    controller.selectedXValue.value = touchedSpot.x;
                                                  },
                                                ),

                                                extraLinesData: ExtraLinesData(
                                                  verticalLines: [
                                                    VerticalLine(
                                                      x: controller.selectedXValue.value,
                                                      color: Colors.redAccent,
                                                      strokeWidth: 1.5,
                                                      dashArray: [6, 4],
                                                    ),
                                                  ],
                                                ),

                                                minX: 0,
                                                maxX: 11,
                                                minY: 0,
                                                maxY: 400,
                                              ),
                                            ))
                                          ),
                                          SizedBox(height: 20.h),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              LegendDot(color: Colors.purple, text: 'New Signups'),
                                              SizedBox(width: 20),
                                              LegendDot(color: Colors.red, text: 'Videos Generated'),
                                              SizedBox(width: 20),
                                              LegendDot(color: Colors.green, text: 'Active Subscribers'),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 32.h,),
                            Row(
                              spacing: 31.w,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    height: 348.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: kWhiteColor,
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 4),
                                          blurRadius: 20,
                                          spreadRadius: 0,
                                          color: kWhiteShade6Color,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(24),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Revenue by Week",
                                            overflow: TextOverflow.ellipsis,
                                            style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w600,fontSize: 16.sp,color: kDarkBlueColor1),
                                          ),
                                          SizedBox(height: 25.h,),
                                          Expanded(
                                            child: Obx(() {
                                              final data = controller.weeklyRevenue;
                                              if (data.isEmpty) {
                                                return Center(child: Text("No data available"));
                                              }

                                              return BarChart(
                                                BarChartData(
                                                  barGroups: data.asMap().entries.map((entry) {
                                                    final index = entry.key;
                                                    final item = entry.value;
                                                    return BarChartGroupData(
                                                      x: index,
                                                      barRods: [
                                                        BarChartRodData(
                                                          toY: item.subscriptionRevenue,
                                                          width: 10,
                                                          color: kDarkPurpleColor2,
                                                          borderRadius: BorderRadius.circular(2),
                                                        ),
                                                        BarChartRodData(
                                                          toY: item.creditPurchases,
                                                          width: 10,
                                                          color: kLightPurpleColor2,
                                                          borderRadius: BorderRadius.circular(2),
                                                        ),
                                                      ],
                                                      barsSpace: 4,
                                                    );
                                                  }).toList(),
                                                  groupsSpace: 20,
                                                  titlesData: FlTitlesData(
                                                    bottomTitles: AxisTitles(
                                                      sideTitles: SideTitles(
                                                        showTitles: true,
                                                        getTitlesWidget: (value, meta) {

                                                          if (value.toInt() >= data.length) return const SizedBox.shrink();
                                                          return SideTitleWidget(
                                                            axisSide: meta.axisSide,
                                                            child: Text(data[value.toInt()].day, style: AppStyles.greyTextStyle().copyWith(fontSize: 12,color: kGreyColor8,fontWeight: FontWeight.w400)),
                                                          );

                                                        },
                                                      ),
                                                    ),
                                                    leftTitles: AxisTitles(
                                                      sideTitles: SideTitles(
                                                        showTitles: true,
                                                        interval: 5,
                                                        getTitlesWidget: (value, meta) => Text('${value.toInt()}k',style: AppStyles.blackTextStyle().copyWith(fontSize: 11,fontWeight: FontWeight.w400,color: kGreyColor8),),
                                                      ),
                                                    ),
                                                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                                  ),
                                                  gridData: FlGridData(
                                                    show: true,
                                                    drawVerticalLine: false,
                                                    getDrawingHorizontalLine: (value) => FlLine(
                                                      color: kGreyColor9,
                                                      strokeWidth: 1,
                                                    ),
                                                  ),
                                                  borderData: FlBorderData(show: false),
                                                ),
                                              );
                                            })
                                          ),
                                          SizedBox(height: 24.h,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              LegendDot(color: kDarkPurpleColor2, text: 'Subscription Revenue'),
                                              SizedBox(width: 37.w),
                                              LegendDot(color: kLightPurpleColor2, text: ' Credit Purchases (top-ups)'),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 348.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: kWhiteColor,
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 4),
                                          blurRadius: 20,
                                          spreadRadius: 0,
                                          color: kWhiteShade6Color,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(24),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "User Distribution by Country",
                                            overflow: TextOverflow.ellipsis,
                                            style: AppStyles.blackTextStyle().copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.sp,
                                              color: kDarkBlueColor1,
                                            ),
                                          ),
                                          SizedBox(height: 32.h),
                                          Expanded(
                                            child: SfMaps(
                                              layers: [
                                                MapShapeLayer(
                                                  source: controller.mapSource,
                                                  showDataLabels: false,
                                                  strokeColor: kWhiteShade7Color,
                                                  strokeWidth: 0.5,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 348.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: kWhiteColor,
                                      boxShadow: [
                                        BoxShadow(
                                          offset: const Offset(0, 4),
                                          blurRadius: 20,
                                          spreadRadius: 0,
                                          color: kWhiteShade6Color,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(24),
                                      child: Obx(() {
                                        final actual = controller.actualVideos;
                                        final target = controller.targetVideos;
                                        final months = controller.months;

                                        final safeLength = [actual.length, target.length, months.length].reduce((a, b) => a < b ? a : b);

                                        if (safeLength == 0) {
                                          return const Center(child: Text("No data available"));
                                        }

                                        final barGroups = List.generate(safeLength, (index) {
                                          return BarChartGroupData(
                                            x: index,
                                            barsSpace: 4,
                                            barRods: [
                                              BarChartRodData(
                                                toY: actual[index],
                                                width: 12,
                                                borderRadius: BorderRadius.circular(2),
                                                color: kGreenColor5,
                                              ),
                                              BarChartRodData(
                                                toY: target[index],
                                                width: 12,
                                                borderRadius: BorderRadius.circular(2),
                                                color: kYellowColor,
                                              ),
                                            ],
                                          );
                                        });

                                        final maxY = ((actual.take(safeLength).toList() + target.take(safeLength).toList()).reduce((a, b) => a > b ? a : b) + 2).toDouble();

                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Target vs Actual Videos Generated",
                                              overflow: TextOverflow.ellipsis,
                                              style: AppStyles.blackTextStyle().copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.sp,
                                                color: kDarkBlueColor1,
                                              ),
                                            ),
                                            // SizedBox(height: 24.h),
                                            SizedBox(
                                              height: 157.h,
                                              child: BarChart(
                                                BarChartData(
                                                  alignment: BarChartAlignment.spaceAround,
                                                  maxY: maxY,
                                                  barGroups: barGroups,
                                                  titlesData: FlTitlesData(
                                                    bottomTitles: AxisTitles(
                                                      sideTitles: SideTitles(
                                                        showTitles: true,
                                                        interval: 1,
                                                        reservedSize: 32,
                                                        getTitlesWidget: (value, _) {
                                                          final idx = value.toInt();
                                                          if (idx < 0 || idx >= months.length) {
                                                            return const SizedBox.shrink();
                                                          }
                                                          return Text(
                                                            months[idx],
                                                            style: AppStyles.greyTextStyle().copyWith(fontSize: 12.sp, color: kGreyColor8,fontWeight: FontWeight.w400)
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                                  ),
                                                  gridData: FlGridData(show: false),
                                                  borderData: FlBorderData(show: false),
                                                  barTouchData: BarTouchData(enabled: false),
                                                ),
                                              ),
                                            ),
                                            // SizedBox(height: 18.h),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 36.h,
                                                  width: 36.w,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(6),
                                                    color: kGreenLight1Color
                                                  ),
                                                  child: Center(child: SvgPicture.asset(kBagIcon,height: 16,width: 16,)),
                                                ),
                                                SizedBox(width: 8.w,),
                                                Text(
                                                  "Actual Generated Videos",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: AppStyles.blackTextStyle().copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 10.sp,
                                                    color: kDarkBlueColor1,
                                                  ),
                                                ),
                                                SizedBox(width: 20.w,),
                                                Text(
                                                  "8.823",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: AppStyles.blackTextStyle().copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14.sp,
                                                    color: kGreenColor6,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // SizedBox(height: 18.h),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 36.h,
                                                  width: 36.w,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(6),
                                                    color: kYellowLightColor
                                                  ),
                                                  child: Center(child: SvgPicture.asset(kTicketIcon,height: 16,width: 16,)),
                                                ),
                                                SizedBox(width: 8.w,),
                                                Text(
                                                  "Target Videos",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: AppStyles.blackTextStyle().copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 10.sp,
                                                    color: kDarkBlueColor1,
                                                  ),
                                                ),
                                                SizedBox(width: 20.w,),
                                                Text(
                                                  "12.122",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: AppStyles.blackTextStyle().copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14.sp,
                                                    color: kOrangeColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      }),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


