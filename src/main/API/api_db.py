import cx_Oracle
import os
import xml.etree.ElementTree as ET

# Oracle DB 연결 설정
def connect_to_db():
    # DB 연결
    return cx_Oracle.connect("mp_24K_bigdata28_p2_3/smhrd3@project-db-cgi.smhrd.com:1524/xe")

# XML 파일에서 SQL 쿼리 로드하는 함수
def get_query_from_xml(query_id):
     # 상대 경로로 XML 파일 읽기
    file_path = os.path.join(os.path.dirname(__file__), 'resources', 'chattingMapper.xml')
    # XML 파일을 파싱
    tree = ET.parse(file_path)
    root = tree.getroot()

    # query_id에 해당하는 query를 찾기
    query = root.find(f".//query[@id='{query_id}']").text.strip()
    return query

# DB에서 지역 리스트를 조회하는 함수
def get_regions():
    query = get_query_from_xml("get_regions")  # 'get_regions' 쿼리 가져오기

    conn = connect_to_db()
    cursor = conn.cursor()

    cursor.execute(query)
    regions = [row[0] for row in cursor.fetchall()]  # 결과에서 지역 이름만 추출

    cursor.close()
    conn.close()

    return regions

# DB에서 지역 및 복지 분류에 맞는 정책 조회 함수
def get_policyList(region=None, welfare_category=None):
    conn = connect_to_db()
    cursor = conn.cursor()

    # 지역과 복지 분류가 모두 없으면 전체 조회
    if not region and not welfare_category:
        query = get_query_from_xml('get_all_policies')
        cursor.execute(query)  # 이 쿼리는 바인딩 변수를 필요로 하지 않음
    # 지역만 없으면, 복지 분류로만 조회
    elif not region:
        query = get_query_from_xml('get_policy_by_category')
        # 여러 개의 지역을 처리하기 위해 IN 구문을 사용
        query = query.replace(":welfare_category", ",".join([f":wc{i}" for i in range(len(welfare_category))]))
        cursor.execute(query, {f'wc{i}': wc for i, wc in enumerate(welfare_category)})  # 바인딩 변수 사용
    # 복지 분류만 없으면, 지역으로만 조회
    elif not welfare_category:
        query = get_query_from_xml('get_policy_by_region')
        # 여러 개의 지역을 처리하기 위해 IN 구문을 사용
        query = query.replace(":region", ",".join([f":r{i}" for i in range(len(region))]))
        cursor.execute(query, {f'r{i}': r for i, r in enumerate(region)})  # 바인딩 변수 사용
    # 지역과 복지 분류 둘 다 있으면 둘 다 조건으로 조회
    else:
        query = get_query_from_xml('get_policy_by_region_and_category')
         # 여러 개의 지역과 복지분류를 처리하기 위해 IN 구문을 사용
        query = query.replace(":region", ",".join([f":r{i}" for i in range(len(region))]))
        query = query.replace(":welfare_category", ",".join([f":wc{i}" for i in range(len(welfare_category))]))
        # 바인딩 변수 사용
        cursor.execute(query, {f'r{i}': r for i, r in enumerate(region)} | {f'wc{i}': wc for i, wc in enumerate(welfare_category)})
    
    result = cursor.fetchall() # fetchall() : 쿼리 결과를 모두 가져옴
                                # cursor: 데이터베이스에 쿼리를 전송하고 결과를 받아오는 도구
                                # cursor.execute() : 메서드를 통해 sQL쿼리를 실행

    # LOB(대용량, Large Object) 데이터(WELFARE_CONTENT 컬럼이 CLOB 타입)를 명시적으로 읽어오기
    # LOB - BLOB 타입, CLOB 타입이 있음
    data = []
    for row in result:
        row_data = list(row)
        for i in range(len(row_data)):
            # LOB 타입이 있는 경우 읽어오기
            if isinstance(row_data[i], cx_Oracle.LOB):
                row_data[i] = row_data[i].read() # LOB 데이터를 읽어옴
        data.append(row_data)

    cursor.close()
    conn.close()

    return data
